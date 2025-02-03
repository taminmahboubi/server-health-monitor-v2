# server-health-monitor-v2
another script to monitor CPU, memory, disk usage

first we want the 5-minute CPU load average, using the command:

- uptime
to give a quick summary of the systems status 
example:- 

15:32:45 up  2:15,  3 users,  load average: 0.08, 0.03, 0.01 


- awk 
to extract it, in this case:

uptime | awk '{print $10}'

$1: 15:32:45
$2: up
$3: 2:15,
$4: 3
$5: users,
$6: load
$7: average:
$8: 0.08,    <-- 1-minute load average
$9: 0.03,    <-- 5-minute load average
$10: 0.01    <-- 15-minute load average

and echo the result.

----------------------------------------------------------------------
then we want the memory usage:

using the commands:

-free
to display information about the system's memory usage.
example:-
              total        used        free      shared  buff/cache   available
Mem:        16384000     4096000     8192000      204800     4096000    12288000
Swap:       2097152      1048576     1048576

- '-m'
to display the memory usage in megabytes:
          total        used        free      shared  buff/cache   available
Mem:          15993        4096        8192         200        4096       12288
Swap:          2048        1024        1024

- awk
to extract the 'used' memory $3:
$1: Mem:
$2: 15993    <-- Total memory (MB)
$3: 4096     <-- Used memory (MB)   <--- This one!
$4: 8192     <-- Free memory (MB)
$5: 200      <-- Shared memory (MB)
$6: 4096     <-- Buff/cache memory (MB)
$7: 12288    <-- Available memory (MB) 


then echo the result.


-----------------------------------------------------------------------------
then we want disk usage:

using the commands: 

-df 
to display information about the disk space usage for all mounted filesystems.
example:-

Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sda1       10485760 4194304   6291456  40% /
tmpfs             819200       0    819200   0% /dev/shm


-'-h' 
this option displays the disk usage in a human-readable format(kb,mb,gb)
example:-

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        10G  4.0G  6.0G  40% /
tmpfs           800M     0  800M   0% /dev/shm

- '/'
this argument specifies that only the root filesystem should be displayed.
exmaple:-

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        10G  4.0G  6.0G  40% /


- awk
to extract the used percentage $5:
$1: Filesystem  (/dev/sda1)
$2: Size        (10G)
$3: Used        (4.0G)
$4: Avail       (6.0G)
$5: Use%        (40%) <--- this one
$6: Mounted on  (/)


then echo the output.

