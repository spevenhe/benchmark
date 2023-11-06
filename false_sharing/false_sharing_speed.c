#define _GNU_SOURCE
#include <sys/times.h>
#include <time.h>
#include <stdio.h> 
#include <stdlib.h>
#include <sched.h>
#include <pthread.h> 
#include <malloc.h>
#include <numa.h>
#define SIZE 100
struct timespec tpBegin1,tpEnd1,tpBegin2,tpEnd2,tpBegin3,tpEnd3;  //These are inbuilt structures to store the time related activities
struct timespec tpBegin1_,tpEnd1_,tpBegin2_,tpEnd2_,tpBegin3_,tpEnd3_;
//test1 struct with false sharing
typedef struct {
    int num_int;
    long num_long;
    int arr[16];
}test1;
//test2 struct without false sharing
typedef struct {
    int num_int;
    int arr[16];
    long num_long;   
}test2;

double compute(struct timespec start,struct timespec end) //computes time in milliseconds given endTime and startTime timespec structures.
{
  double t;
  t=(end.tv_sec-start.tv_sec)*1000;
  t+=(end.tv_nsec-start.tv_nsec)*0.000001;
  return t;
}

int array[SIZE];
void *array_function(void *param) {     
  int   index = *((int*)param);
  int   i;
  for (i = 0; i < 100000000; i++)
    array[index]+=1;
} 

void *struct_function(void *param) {     
  int *data = (int *)param;
  int cpu = sched_getcpu();
  int node = numa_node_of_cpu(cpu);
  printf("thread on node %d (cpu %d).\n", node, cpu);  
  for (int i = 0; i < 100000000; i++)
    *data +=1;
} 

int main(int argc, char *argv[]) { 

  int NUM_THREADS = atoi(argv[1]);
  pthread_t thread[2*NUM_THREADS];
  int       first_elem  = 0;
  int       bad_elem    = 1;
  int       good_elem   = 16;
  double time1;
  double time2;
  double time3;
  double time1_;
  double time2_;
  double time3_;
  
  test1 *t1 = (test1 *)malloc(sizeof(test1));
  t1->num_int = 1;
  t1->num_long = 1;
  
  test2 *t2 = (test2 *)malloc(sizeof(test2));
  t2->num_int = 1;
  t2->num_long = 1;

  //---------------------------struct  test----------------------------
  //---------------------------START--------Serial Computation---------------------------------------------
  clock_gettime(CLOCK_REALTIME,&tpBegin1);
  for(int i = 0;i<NUM_THREADS;i++){
    struct_function((void*)&t1->num_int);
    struct_function((void*)&t1->num_long);
  }
  clock_gettime(CLOCK_REALTIME,&tpEnd1);
  //---------------------------END----------Serial Computation---------------------------------------------
  printf("Sequential: test1.num_int: %d\t\t test2.num_int: %d\n", t1->num_int,t1->num_long);
  t1->num_int = 1;
  t1->num_long = 1;

  //---------------------------START--------parallel computation with False Sharing----------------------------
  clock_gettime(CLOCK_REALTIME,&tpBegin2);
  for(int i = 0; i< 2*NUM_THREADS;i+=2){
    pthread_create(&thread[i], NULL,struct_function, (void*)&t1->num_int);
    pthread_create(&thread[i+1], NULL,struct_function, (void*)&t1->num_long);
  }
  for(int i = 0; i< 2*NUM_THREADS;i+=2){
      pthread_join(thread[i], NULL);
      pthread_join(thread[i+1], NULL);
  }
  clock_gettime(CLOCK_REALTIME,&tpEnd2);
  printf("parallel computation with False Sharing: test1.num_int: %d\t\t test1.num_int: %d\n", t1->num_int,t1->num_long);
  //---------------------------END----------parallel computation with False Sharing----------------------------

  //---------------------------START--------parallel computation without False Sharing------------------------
  clock_gettime(CLOCK_REALTIME,&tpBegin3);   
  for(int i = 0; i< 2*NUM_THREADS;i+=2){
    pthread_create(&thread[i], NULL,struct_function, (void*)&t2->num_int);
    pthread_create(&thread[i+1], NULL,struct_function, (void*)&t2->num_long);
  }
  for(int i = 0; i< 2*NUM_THREADS;i+=2){
      pthread_join(thread[i], NULL);
      pthread_join(thread[i+1], NULL);
  }
  clock_gettime(CLOCK_REALTIME,&tpEnd3);
  printf("parallel computation without False Sharing: test2.num_int: %d\t\t test2.num_int: %d\n", t2->num_int,t2->num_int);
  //---------------------------END--------parallel computation without False Sharing------------------------

  //--------------------------START------------------OUTPUT STATS--------------------------------------------
  printf("experiment with struct\n");
  printf("test1.num_int: %d\t\t test2.num_int: %d\n", t1->num_int,t2->num_int);

  time1 = compute(tpBegin1,tpEnd1);
  time2 = compute(tpBegin2,tpEnd2);
  time3 = compute(tpBegin3,tpEnd3);
  printf("datastruct struct —— Time take with false sharing  (parallel)    : %f ms\n", time2);
  printf("datastruct struct —— Time taken without false sharing (parallel) : %f ms\n", time3);
  printf("datastruct struct —— Time taken in Sequential computing          : %f ms\n", time1);

  // --------------------- array test-----------------------------------
  //---------------------------START--------Serial Computation---------------------------------------------

//   clock_gettime(CLOCK_REALTIME,&tpBegin1_);
//   array_function((void*)&first_elem);
//   array_function((void*)&bad_elem);
//   clock_gettime(CLOCK_REALTIME,&tpEnd1_);

//   //---------------------------END----------Serial Computation---------------------------------------------

//   //---------------------------START--------parallel computation with False Sharing----------------------------
//   clock_gettime(CLOCK_REALTIME,&tpBegin2_);
//   pthread_create(&thread_1, NULL,array_function, (void*)&first_elem);
//   pthread_create(&thread_2, NULL,array_function, (void*)&bad_elem);
//   pthread_join(thread_1, NULL);
//   pthread_join(thread_2, NULL);
//   clock_gettime(CLOCK_REALTIME,&tpEnd2_);
//   //---------------------------END----------parallel computation with False Sharing----------------------------

//   //---------------------------START--------parallel computation without False Sharing------------------------
//   clock_gettime(CLOCK_REALTIME,&tpBegin3_);   
//   pthread_create(&thread_1, NULL,array_function, (void*)&first_elem);
//   pthread_create(&thread_2, NULL,array_function, (void*)&good_elem);
//   pthread_join(thread_1, NULL);
//   pthread_join(thread_2, NULL);
//   clock_gettime(CLOCK_REALTIME,&tpEnd3_);

//   //---------------------------END--------parallel computation without False Sharing------------------------
//   //--------------------------START------------------OUTPUT STATS--------------------------------------------
//   printf("\n\nexperiment with array\n");
//   printf("array[first_element]: %d\t\t array[bad_element]: %d\t\t array[good_element]: %d\n", array[first_elem],array[bad_elem],array[good_elem]);
//   time1_ = compute(tpBegin1_,tpEnd1_);
//   time2_ = compute(tpBegin2_,tpEnd2_);
//   time3_ = compute(tpBegin3_,tpEnd3_);
//   printf("datastruct array —— Time take with false sharing (parallel)    : %f ms\n", time2_);
//   printf("datastruct array —— Time taken without false sharing (parallel): %f ms\n", time3_);
//   printf("datastruct array —— Time taken in Sequential computing         : %f ms\n", time1_);
  //--------------------------END------------------OUTPUT STATS--------------------------------------------
  return 0; 
}