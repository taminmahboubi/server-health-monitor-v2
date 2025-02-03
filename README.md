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
