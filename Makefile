#!/bin/sh
.SILENT:

default:
	gcc -g -pthread lab2_add.c -o lab2_add
	gcc -g -pthread lab2_list.c SortedList.c -o lab2_list

tests: default
	# range of threads and iterations to see what it takes to cause a failure
	./lab2_add --threads=2  --iterations=100    >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=1000   >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000  >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=100000 >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=100    >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=1000   >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000  >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=100000 >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=100    >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=1000   >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=10000  >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=100000 >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=100    >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=1000   >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=10000  >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=100000  >> lab2_add_tests.csv
	# range of threads and iterations to cause failure with yield
	./lab2_add --threads=2  --iterations=10     --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10     --yield >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=10     --yield >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=10     --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=20     --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=20     --yield >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=20     --yield >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=20     --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=40     --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=40     --yield >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=40     --yield >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=40     --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=80     --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=80     --yield >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=80     --yield >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=80     --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=100    --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=100    --yield >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=100    --yield >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=100    --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=1000   --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=1000   --yield >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=1000   --yield >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=1000   --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000  --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000  --yield >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=10000  --yield >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=10000  --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=100000 --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=100000 --yield >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=100000 --yield >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=100000 --yield >> lab2_add_tests.csv
	# look at cost per operation vs number of iterations
	./lab2_add --threads=1  --iterations=100         >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=1000        >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=10000       >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=100000      >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=1000000     >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=100         >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=1000        >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000       >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=100000      >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=1000000     >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=100         >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=1000        >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000       >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=100000      >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=1000000     >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=100     --yield >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=1000    --yield >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=10000   --yield >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=100000  --yield >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=1000000 --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=100     --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=1000    --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000   --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=100000  --yield >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=1000000 --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=100     --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=1000    --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000   --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=100000  --yield >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=1000000 --yield >> lab2_add_tests.csv
	# demonstrate the efficacy of each of the protection mechanisms
	./lab2_add --threads=2  --iterations=10000 --yield --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000 --yield --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=10000 --yield --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=10000 --yield --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000 --yield --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000 --yield --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=10000 --yield --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=10000 --yield --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000 --yield --sync=s >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000 --yield --sync=s >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=1000  --yield --sync=s >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=1000  --yield --sync=s >> lab2_add_tests.csv
	# generate time per operation numbers
	./lab2_add --threads=1  --iterations=10000 --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000 --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000 --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=10000 --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=10000 --sync=m >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=10000 --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000 --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000 --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=10000 --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=10000 --sync=c >> lab2_add_tests.csv
	./lab2_add --threads=1  --iterations=10000 --sync=s >> lab2_add_tests.csv
	./lab2_add --threads=2  --iterations=10000 --sync=s >> lab2_add_tests.csv
	./lab2_add --threads=4  --iterations=10000 --sync=s >> lab2_add_tests.csv
	./lab2_add --threads=8  --iterations=10000 --sync=s >> lab2_add_tests.csv
	./lab2_add --threads=12 --iterations=10000 --sync=s >> lab2_add_tests.csv

	# generate time per operation vs number of iterations
	./lab2_list --threads=1  --iterations=10	      >> lab2_list_tests.csv
	./lab2_list --threads=1  --iterations=100	      >> lab2_list_tests.csv
	./lab2_list --threads=1  --iterations=1000	      >> lab2_list_tests.csv
	./lab2_list --threads=1  --iterations=10000	      >> lab2_list_tests.csv
	./lab2_list --threads=1  --iterations=20000	      >> lab2_list_tests.csv
	# conflicts w/o yielding
	-./lab2_list --threads=2  --iterations=10  2> /dev/null           | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=100   2> /dev/null         | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=1000  2> /dev/null         | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=10   2> /dev/null          | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=100    2> /dev/null        | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=1000  2> /dev/null         | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=10      2> /dev/null       | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=100    2> /dev/null        | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=1000   2> /dev/null        | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=10     2> /dev/null        | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=100     2> /dev/null       | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=1000   2> /dev/null        | cat >> lab2_list_tests.csv
	# generate insert conflicts
	-./lab2_list --threads=2  --iterations=2   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=4   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=8   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=16  --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=32  --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=2   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=4   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=8   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=16  --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=2   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=4   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=8   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=16  --yield=i 2> /dev/null  | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=2   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=4   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=8   --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=16  --yield=i 2> /dev/null | cat >> lab2_list_tests.csv
	# generate delete conflicts
	-./lab2_list --threads=2  --iterations=2   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=4   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=8   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=16  --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=32  --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=2   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=4   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=8   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=16  --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=2   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=4   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=8   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=16  --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=2   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=4   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=8   --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=16  --yield=d 2> /dev/null | cat >> lab2_list_tests.csv
	# generate insert/lookup conflicts
	-./lab2_list --threads=2  --iterations=2   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=4   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=8   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=16  --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=32  --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=2   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=4   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=8   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=16  --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=2   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=4   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=8   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=16  --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=2   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=4   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=8   --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=16  --yield=il 2> /dev/null | cat >> lab2_list_tests.csv
	# generate delete/lookup conflicts
	-./lab2_list --threads=2  --iterations=2   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=4   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=8   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=16  --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=2  --iterations=32  --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=2   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=4   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=8   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=4  --iterations=16  --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=2   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=4   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=8   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=8  --iterations=16  --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=2   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=4   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=8   --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	-./lab2_list --threads=12 --iterations=16  --yield=dl 2> /dev/null | cat >> lab2_list_tests.csv
	# demonstrate the efficacy of mutex and spin-lock synchronization
	./lab2_list --threads=12 --iterations=32 --yield=i  --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=32 --yield=d  --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=32 --yield=il --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=32 --yield=dl --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=32 --yield=i  --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=32 --yield=d  --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=32 --yield=il --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=32 --yield=dl --sync=s >> lab2_list_tests.csv
	# measure the performance
	./lab2_list --threads=1  --iterations=1000          >> lab2_list_tests.csv
	./lab2_list --threads=1  --iterations=1000 --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=2  --iterations=1000 --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=4  --iterations=1000 --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=8  --iterations=1000 --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=1000 --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=16 --iterations=1000 --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=24 --iterations=1000 --sync=m >> lab2_list_tests.csv
	./lab2_list --threads=1  --iterations=1000 --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=2  --iterations=1000 --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=4  --iterations=1000 --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=8  --iterations=1000 --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=12 --iterations=1000 --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=16 --iterations=1000 --sync=s >> lab2_list_tests.csv
	./lab2_list --threads=24 --iterations=1000 --sync=s >> lab2_list_tests.csv

graphs:
	/usr/local/cs/bin/gnuplot lab2_add.gp
	/usr/local/cs/bin/gnuplot lab2_list.gp

tarball:
	tar -cvf lab2a-704666892.tar.gz lab2_add.csv lab2_list.csv lab2_add.c lab2_list.c Makefile README.txt lab2_add.csv lab2_list.csv lab2_add-1.png lab2_add-2.png lab2_add-3.png lab2_add-4.png lab2_add-5.png lab2_list-1.png lab2_list-2.png lab2_list-3.png lab2_list-4.png SortedList.h SortedList.c

clean: default
	-rm lab2_list lab2_add lab2_list_tests.csv lab2_add_tests.csv 2>/dev/null
