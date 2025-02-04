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

---------------------------------------------------------------
-adding threshholds of 90, a default threshold for cpu, memory and disk usage
-adding basic alerts

if statements to compare the cpu/memory/disk usage to the thresholds:
if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
	echo "ALERT!: CPU usage is $cpu_usage% !"
fi

-gt 
greather than


- tr -d ','
the -d tells 'tr' to delete specified characters, in this case ',' all commas

-------------------------------------------------------------------
EDIT:

-change threshold for cpu and disk usage to 90.0

-calculate the cpu usage=$(uptime | awk '{print $(NF-2)' | tr -d ',')

-change the if statements for cpu and disk usage to:
	if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then ..
to handle floating point numbers!


---------------------------------------------------------------------
-create a log entry at: /var/log/server_health.log   <---- this is the log file

# Log file
ALERT_LOG="/var/log/server_health.log"

- create a function to use for each log alert, giving the date plus the first argument (in our case, text + the cup/memory/disk usage)
log_alert(){
   echo "[$(date)] Alert!: $1" >> "$ALERT_LOG"
}

function use:-

log_alert "CPU usage is: $cpu_usage"

 

