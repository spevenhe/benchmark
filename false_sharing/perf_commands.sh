gcc -g false_sharing_example.c -pthread -lnuma -o false_sharing
perf c2c record taskset -c 2-5 ./false_sharing 8
perf c2c report -NN -g --call-graph -c pid,iaddr --full-symbols --stdio