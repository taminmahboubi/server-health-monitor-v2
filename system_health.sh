#!/bin/bash

# Display the CPU usage

cpu_usage=$(uptime | awk '{print $10}')
echo "CPU Usage: $cpu_usage"

# Display the memory usage

memory_usage=$(free -m | awk '/Mem:/ {print $3}')
echo "Memory Usage: $memory_usage MB"
