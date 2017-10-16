#include <stdio.h>
#include <getopt.h>
#include <time.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include "SortedList.h"

#define KEY_LEN 10

extern char* optarg;
int rc = 0;
int opt_yield = 0;
int sync = 0;
int opt_mutex = 0;
int opt_spin = 0;
int num_threads = 1;
long long num_iterations = 1;
struct timespec start, end;
long long list_length = 0;
SortedListElement_t* elements;
pthread_mutex_t lock;
int spin_lock = 0;
int num = 0;
SortedListElement_t list_head; // = malloc(sizeof(SortedListElement_t));

typedef struct arg_struct {
  // SortedList_t* list;
   long long start;
  //SortedListElement_t* elements;
} arg_struct;

char* random_gen(const int len){
  char* s = malloc(len);
  static const char alphanum[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefgijklmnopqrstuvwxyz";
  for (int i = 0; i < len; i++){
    s[i] = alphanum[rand() % (sizeof(alphanum) - 1)];
  }
  return s;
}

void *thr_func(void *arg){
  struct arg_struct *data = arg;
  long long finish = data->start + num_iterations;
  /* add elements */
  if (opt_mutex){
    for (int i = data->start; i < finish; i++){
      pthread_mutex_lock(&lock);
      SortedList_insert(&list_head, &elements[i]);
      pthread_mutex_unlock(&lock);
      num++;
    }
  }
  else if (opt_spin){
    for (int i = data->start; i < finish; i++){
      while (__sync_lock_test_and_set(&spin_lock,1));
      SortedList_insert(&list_head, &elements[i]);
      __sync_lock_release(&spin_lock);
    }
  }
  else {
    for (int i = data->start; i < finish; i++){
      SortedList_insert(&list_head, &elements[i]);
    }
  }
  

  /* get list length */
  if (opt_mutex){
    pthread_mutex_lock(&lock);
    list_length = SortedList_length(&list_head);
    pthread_mutex_unlock(&lock);
  }
  else if (opt_spin){
    while (__sync_lock_test_and_set(&spin_lock,1));
    list_length = SortedList_length(&list_head);
    __sync_lock_release(&spin_lock);
  }
  else {
    list_length = SortedList_length(&list_head);
  }

  SortedListElement_t* element_lookup;
  /* look up and delete elements */
  if (opt_mutex){
    for (int i = data->start; i < finish; i++){
      pthread_mutex_lock(&lock);
      element_lookup = SortedList_lookup(&list_head, elements[i].key);
      if (element_lookup == NULL){
        perror("\nELEMENT DOES NOT EXIST\n");
      };
      if (SortedList_delete(element_lookup) == -1){
        perror("\nERROR DELETING ELEMENT\n");
      };
      pthread_mutex_unlock(&lock);
    }
  }
  else if (opt_spin){
    for (int i = data->start; i < finish; i++){
      while (__sync_lock_test_and_set(&spin_lock,1));
      element_lookup = SortedList_lookup(&list_head, elements[i].key);
      if (element_lookup == NULL){
        perror("\nELEMENT DOES NOT EXIST\n");
      };
      if (SortedList_delete(element_lookup) == -1){
        perror("\nERROR DELETING ELEMENT\n");
      };
      __sync_lock_release(&spin_lock);
    }
  }
  else {
    for (int i = data->start; i < finish; i++){
      element_lookup = SortedList_lookup(&list_head, elements[i].key);
      if (element_lookup == NULL){
        perror("\nELEMENT DOES NOT EXIST\n");
      };
      if (SortedList_delete(element_lookup) == -1){
        perror("\nERROR DELETING ELEMENT\n");
      };
    }
  }
  
}

int main(int argc, char * argv[]){

  static struct option long_options[] = {
    {"threads", required_argument, 0, 'a'},
    {"iterations", required_argument, 0, 'b'},
    {"yield", required_argument, 0, 'c'},
    {"sync", required_argument, 0, 'd'},
    {NULL, 0, NULL, 0},
  };

  int option_index = 0;
  int c = getopt_long(argc, argv, "", long_options, &option_index);
  while (c != -1){
    switch(c){
    case 'a':
      num_threads = atoi(optarg);
      break;
    case 'b':
      num_iterations = atoi(optarg);
      break;
    case 'c':
      for (int i = 0; i < strlen(optarg); i++){
	if (!strncmp(optarg+i, "i",1)){
	  opt_yield |= INSERT_YIELD;
	}
	if (!strncmp(optarg+i, "d",1)){
	  opt_yield |= DELETE_YIELD;
	}
	if (!strncmp(optarg+i, "l",1)){
	  opt_yield |= LOOKUP_YIELD;
	}
      }
      break;
    case 'd':
      if (optarg[0] == 's'){
	sync = 's';
	opt_spin = 1;
      }
      else if (optarg[0] == 'm'){
	sync = 'm';
	opt_mutex = 1;
	if (pthread_mutex_init(&lock, NULL) != 0){
	  printf("ERROR: Mutex init failed!\n");
	  exit(1);
	}
      }
      else {
	perror("INVALID SYNC OPTION!");
	exit(1);
      }
      break;
    default:
      break;
    }
    c = getopt_long(argc, argv, "", long_options, &option_index);
  }

  list_head.prev = &list_head;
  list_head.next = &list_head;
  list_head.key = NULL;

  long long num_elements = num_iterations * num_threads;
  elements = (SortedListElement_t *)malloc(num_elements*sizeof(SortedListElement_t));

  for (long long i = 0; i < num_elements; i++){
    elements[i].key = random_gen(KEY_LEN);
  }

  /* start timer */
  clock_gettime(CLOCK_MONOTONIC, &start);

  pthread_t threads[num_threads];
  //  struct arg_struct args;
  //  args.list = &list_head;
  //  args.elements = &elements;
  struct arg_struct* args = malloc(num_threads*sizeof(arg_struct));
  for (int i = 0; i < num_threads; i++){
    args[i].start = i * num_iterations;
  }
  
  /* create threads */
  for (int i = 0; i < num_threads; i++){
    if ((rc = pthread_create(&threads[i], NULL, thr_func, &args[i]))){
      fprintf(stderr, "ERROR: pthread_create, CODE: %d\n", rc);
      return 1;
    }
  }

  /* wait for threads to finish */
  for (int i = 0; i < num_threads; i++){
    pthread_join(threads[i], NULL);
  }

  /* end timer */
  clock_gettime(CLOCK_MONOTONIC, &end);

  long long total_time_ns = ( (end.tv_sec - start.tv_sec) * 1000000000) + end.tv_nsec - start.tv_nsec;
  long long avg_time_op = total_time_ns / num_elements;
  
  if (SortedList_length(&list_head) != 0){
    fprintf(stderr, "\n%i\n", SortedList_length(&list_head));
    perror("ERROR: List length is not zero!");
    exit(1);
  }

  printf("list-");
  if (opt_yield & INSERT_YIELD){
    printf("i");
  }
  if (opt_yield & DELETE_YIELD){
    printf("d");
  }
  if (opt_yield & LOOKUP_YIELD){
    printf("l");
  }
  if (opt_yield == 0){
    printf("none");
  }
  printf("-");
  if (sync == 'm'){
    printf("m");
  }
  if (sync == 's'){
    printf("s");
  }
  if (sync == 0){
    printf("none");
  }
  printf(",%i,%lli,1,%lli,%lli,%lli\n", num_threads, num_iterations, num_elements, total_time_ns, avg_time_op);

  free(elements);

  return 0;
}
