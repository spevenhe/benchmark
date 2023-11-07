# usage

https://man7.org/linux/man-pages/man1/perf-c2c.1.html

1. record: perf c2c record ./{run} 
perf c2c record taskset -c 0-3 ./false_sharing 4

2. report 
```
 perf c2c report -NN -c pid,iaddr                 // to use the tui interactive report
 perf c2c report -NN -c pid,iaddr --stdio         // or to send the output to stdout
 perf c2c report -NN -d lcl -c pid,iaddr --full-symbols --stdio  // or to sort on local hitms

 perf c2c report -NN -g --call-graph -c pid,iaddr --full-symbols --stdio
 ```

 # which row represents false sharing
 **LLC Misses to Remote Cache (HITM)**
 
 ```
 1  =================================================
 2              Trace Event Information
 3  =================================================
 4    Total records                     :     329219  << Total loads and stores sampled.
 5    Locked Load/Store Operations      :      14654
 6    Load Operations                   :      69679  << Total loads
 7    Loads - uncacheable               :          0
 8    Loads - IO                        :          0
 9    Loads - Miss                      :       3972
10    Loads - no mapping                :          0
11    Load Fill Buffer Hit              :      11958
12    Load L1D hit                      :      17235  << loads that hit in the L1 cache.
13    Load L2D hit                      :         21
14    Load LLC hit                      :      14219  << loads that hit in the last level cache (LLC).
15    Load Local HITM                   :       3402  << loads that hit in a modified cache on the same numa node (local HITM).
16    Load Remote HITM                  :      12757  << loads that hit in a modified cache on a remote numa node (remote HITM).
17    Load Remote HIT                   :       5295
18    Load Local DRAM                   :        976  << loads that hit in the local node's main memory.
19    Load Remote DRAM                  :       3246  << loads that hit in a remote node's main memory.
20    Load MESI State Exclusive         :       4222 
21    Load MESI State Shared            :          0
22    Load LLC Misses                   :      22274  << loads not found in any local node caches.
23    LLC Misses to Local DRAM          :        4.4% << % hitting in local node's main memory.
24    LLC Misses to Remote DRAM         :       14.6% << % hitting in a remote node's main memory.
25    LLC Misses to Remote cache (HIT)  :       23.8% << % hitting in a clean cache in a remote node.
26    **LLC Misses to Remote cache (HITM)** :       57.3% << % hitting in remote modified cache. (most expensive - false sharing)
27    Store Operations                  :     259539  << store instruction sample count
28    Store - uncacheable               :          0
29    Store - no mapping                :         11
30    Store L1D Hit                     :     256696  << stores that got L1 cache when requested.
31    Store L1D Miss                    :       2832  << stores that couldn't get the L1 cache when requested (L1 miss).
32    No Page Map Rejects               :       2376
33    Unable to parse data source       :          1
```