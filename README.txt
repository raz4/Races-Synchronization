README - Races and Synchronization

Primary Objectives:
	1. Demonstrate the ability to recognize critical sections and address them with
	a variety of different mechanisms
	2. Demonstrate the existence of race conditions, and efficacy of the subsequent
	solutions

Secondary Objectives:
	1. Demonstrate the ability to deliver code that meet CLI and API specifications
	2. Experience with basic performance measurement and instrumentation
	3. Experience with application development, exploiting new library functions,
	creating command line options to control non-trivial behavior

Makefile usage:
make: compiles programs lab2_add and lab2_list
make tests: run over 200 commands to test lab2_add and lab2_list, outputs 2 csv files with results
make graphs: generates graphs based on provided lab2_add.csv and lab2_list.csv using gnuplot
make tarball: create a tarball with essential files
make clean: removes all generated files and programs

SortedList usage:
SortedList_insert: insert element into list
SortedList_delete: delete element from list
*SortedList_lookup: find element in list
SortedList_length: get length of list

There are no known limitations to the programs.
Dynamic Allocation was used wherever applicable.
Mutex and Spin locks were called in the for loops.
Code was succesfully tested ONLY on SEASnet LNXSRV09.


Question 2.1.1 - causing conflicts:
Why does it take many iterations before errors are seen?

The threads run for a longer time, so there is a greater chance for the threads to lose synchronization. In other words, the threads are likely to finish their tasks at different times.

Why does a significantly smaller number of iterations so seldom fail?

The threads quickly finish the short task and are more likely to be synchronized since there will be a very small varying time compared to longer tasks.

Question 2.1.2 - cost of yielding:
Why are the --yield runs so much slower?  Where is the additional time going?  Is it possible to get valid per-operation timings if we are using the --yield option?  If so, explain how.  If not, explain why not.

The sched_yield() command causes the thread to relinquish the CPU, and the thread is moved to the end of the queue. The additional time is going to executing other threads which are next in queue. No, it is not possible since the timings will be always different depending on the current state of the system including the number of processes in queue which can vary.

Question 2.1.3 - measurement errors:
Why does the average cost per operation drop with increasing iterations?
If the cost per iteration is a function of the number of iterations, how do we know how many iterations to run (or what the “correct” cost is)?

Creating a thread has fixed overhead cost which is much greater than the cost of each operation. Since only one thread is created and the number of iterations increases, the “average cost per operation” drops. The calculated average cost per operation will be more accurate with larger number of iterations since the cost of creating a thread will be less significant.

Question 2.1.4 - costs of serialization:
Why do all of the options perform similarly for low numbers of threads?

The performance differences among the locking mechanisms is less profound with fewer conflicts (or low numbers of threads). With fewer threads, there are less conflicts and the performance is more similar among the different options.

Why do the three protected operations slow down as the number of threads rises?

With higher number of threads, there are more conflicts and the locking mechanisms will be used more often which will slow down the operations.

Why are spin-lock so expensive for large numbers of threads?

Spin-lock holds the thread by keeping the CPU busy until the lock is released. This method of keeping the thread busy while waiting is expensive especially for large numbers of threads.

Question 2.2.1 - scalability of Mutex
Compare the variation in time per protected operation vs the number of threads (for mutex-protected operations) in Part 1 and Part 2.

Part 1 data shows that spin-lock eventually (with >4 threads) has a higher cost per operation compared to mutex. Also, the cost for mutex eventually levels off with increasing threads. Part 2 data shows that the cost for both mutex and spin-lock increases linearly. Mutex has a higher systematic cost compared to spin-lock across all threads.

Reasons for these results include the fact that there is lighter load between mutex lock and unlock in part 1 compared to part 2. While in Part 1 an integer is simply incremented, in Part 2, a linked list has to be iterated through on average half of the length of the list. So in part 1, before the mutex cost level off, the overhead of locking and unlocking is significant until the number of threads increases to a bigger number. In Part 2, the heavy workload makes the overhead insignificant in the total cost.

Question 2.2.2 - scalability of spin locks
Compare the variation in time per protected operation vs the number of threads for Mutex vs Spin locks.

The cost for mutex and spin locks both increase linearly at the same rate with increasing number of threads. The mutex has a higher systematic cost compared to spin lock. It can be deduced that the spin locking and unlocking mechanism is more efficient in cases where the workload in the critical section is high.