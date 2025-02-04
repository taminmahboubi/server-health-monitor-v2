#!/bin/bash

# Thresholds
CPU_THRESHOLD=90.0
MEM_THRESHOLD=90
DISK_THRESHOLD=90.0

# log files
ALERT_LOG="/var/log/server_health.log"

# Function to log the alerts
log_alert() {
	echo "[$(date)] ALERT!: $1" >> "$ALERT_LOG"
}

echo "----------------------------------------"
# Display CPU usage
cpu_usage=$(uptime | awk '{print $(NF-2)}' | tr -d ',')
echo "CPU Usage: $cpu_usage%"

# Display Memory usage
mem_usage=$(free -m | awk '/Mem:/ {print $3}')
echo "Memory Usage: $mem_usage MB"

# Display Disk usage
disk_usage=$(df -h / | awk '/\// {print $5}' | tr -d '%')
echo "Disk Usage: $disk_usage%"

echo "----------------------------------------"

if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
    echo "!!ALERT!!: CPU usage is $cpu_usage%"
    log_alert "CPU usage is: $cpu_usage%"
fi

if [ "$mem_usage" -gt "$MEM_THRESHOLD" ]; then
    echo "!!ALERT!!: Memory usage is $mem_usage MB"
    log_alert "Memory usage is: $mem_usage MB"
fi

if (( $(echo "$disk_usage > $DISK_THRESHOLD" | bc -l) )); then
    echo "!!ALERT!!: Disk usage is $disk_usage%"
    log_alert "Disk usage is: $disk_usage%"
fi

echo "----------------------------------------"
