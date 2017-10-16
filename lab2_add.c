#include <stdio.h>
#include <pthread.h>
#include <getopt.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

extern char *optarg;

long long num_threads = 1;
long long num_iterations = 1;
long long counter = 0;
struct timespec start, end;
int rc = 0; /* return code */
int opt_yield = 0;
int opt_spin = 0;
int opt_mutex = 0;
int opt_cmp_swp = 0;
pthread_mutex_t lock;
int spin_lock = 0;

void add(long long *pointer, long long value) {
  long long sum = *pointer + value;
  if (opt_yield)
    sched_yield();
  *pointer = sum;
}

void add_mutex(long long *pointer, long long value){
  pthread_mutex_lock(&lock);
  long long sum = *pointer + value;
  if (opt_yield)
    sched_yield();
  *pointer = sum;
  pthread_mutex_unlock(&lock);
}

void add_cmp_swp(long long *pointer, long long value){
  long long prev, sum;
  do {
    prev = *pointer;
    sum = prev + value;
    if (opt_yield)
      sched_yield();
  } while (__sync_val_compare_and_swap(pointer, prev, sum) != prev);

}

typedef struct arg_struct {
  int arg_value;
  long long arg_iterations;
} arg_struct;

void *add_iterations(void *arg){
  struct arg_struct *data = arg;
  if (opt_mutex){
      for (long long i = 0; i < (data->arg_iterations); i++){
	add_mutex(&counter, data->arg_value);
      }
  }
  else if (opt_spin){
    for (long long i = 0; i < (data->arg_iterations); i++){
      while (__sync_lock_test_and_set(&spin_lock,1));
      add(&counter, data->arg_value);
      __sync_lock_release(&spin_lock);
    }
  }
  else if (opt_cmp_swp){
    for (long long i = 0; i < (data->arg_iterations); i++){
        add_cmp_swp(&counter, data->arg_value);
    }
  }
  else {
    for (long long i = 0; i < (data->arg_iterations); i++){
        add(&counter, data->arg_value);
    }
  }
}

int main(int argc, char * argv[]){
  static struct option long_options[] = {
    {"threads", required_argument, 0, 'a'},
    {"iterations", required_argument, 0, 'b'},
    {"yield", no_argument, 0, 'c'},
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
      opt_yield = 1;
      break;
    case 'd':
      if (!strcmp(optarg, "m")){
	opt_mutex = 1;
	if (pthread_mutex_init(&lock, NULL) != 0){
	  printf("ERROR: Mutex init failed!\n");
	  exit(1);
	}
      }
      if (!strcmp("c", optarg)){
        opt_cmp_swp = 1;
      }
      if (!strcmp("s", optarg)){
	opt_spin = 1;
      }
      break;
    default:
      break;
    }
    c = getopt_long(argc, argv, "", long_options, &option_index);
  }

  /* start timer */
  clock_gettime(CLOCK_MONOTONIC, &start);
  
  pthread_t threads[num_threads];
  struct arg_struct args;
  args.arg_iterations = num_iterations;
  args.arg_value = 1;

  /* create threads, add 1 to counter */
  for (int i = 0; i < num_threads; i++){
    if ((rc = pthread_create(&threads[i], NULL, add_iterations, &args))){
      fprintf(stderr, "ERROR: pthread_create, CODE: %d\n", rc);
      return 1;
    }
  }
  
  // wait for threads to finish
  for (int i = 0; i < num_threads; i++){
    pthread_join(threads[i], NULL);
  }

  /* create threads, add -1 to counter */
  args.arg_value = -1;
  for (int i = 0; i < num_threads; i++){
    if ((rc = pthread_create(&threads[i], NULL, add_iterations, &args))){
      fprintf(stderr, "ERROR: pthread_create, CODE: %d\n", rc);
      exit(1);
    }
  }

  /* wait for threads to finish */
  for (int i = 0; i < num_threads; i++){
    pthread_join(threads[i], NULL);
  }

  if (opt_mutex){
    pthread_mutex_destroy(&lock);
  }

  clock_gettime(CLOCK_MONOTONIC, &end);
  long long num_ops = num_threads * num_iterations;
  long long total_time_ns = ( (end.tv_sec - start.tv_sec) * 1000000000) + end.tv_nsec - start.tv_nsec;
  long long avg_time_op = total_time_ns / num_ops;
  
  printf("add");
  if (opt_yield){
    printf("-yield");
  }
  if (opt_mutex){
    printf("-m,");
  }
  else if (opt_spin){
    printf("-s,");
  }
  else if (opt_cmp_swp){
    printf("-c,");
  }
  else {
    printf("-none,");
  }
  printf("%lli,%lli,%lli,%lli,%lli,%lli\n", num_threads, num_iterations, num_ops, total_time_ns, avg_time_op, counter);
  
  return 0;
}
