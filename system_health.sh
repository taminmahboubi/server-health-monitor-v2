#!/bin/bash

# Display the CPU usage

cpu_usage=$(uptime | awk '{print $10}')
echo "CPU Usage: $cpu_usage"
