#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

# Log file
LOG_FILE="/var/log/system_health.log"

# Function to check CPU usage
check_cpu_usage() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "CPU Usage: $CPU_USAGE%"
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        echo "$(date): CPU usage is above $CPU_THRESHOLD% - Current usage: $CPU_USAGE%" >> $LOG_FILE
    fi
}

# Function to check memory usage
check_mem_usage() {
    MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Memory Usage: $MEM_USAGE%"
    if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
        echo "$(date): Memory usage is above $MEM_THRESHOLD% - Current usage: $MEM_USAGE%" >> $LOG_FILE
    fi
}

# Function to check disk space usage
check_disk_usage() {
    DISK_USAGE=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
    echo "Disk Usage: $DISK_USAGE%"
    if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
        echo "$(date): Disk usage is above $DISK_THRESHOLD% - Current usage: $DISK_USAGE%" >> $LOG_FILE
    fi
}

# Function to check running processes
check_processes() {
    RUNNING_PROCESSES=$(ps aux | wc -l)
    echo "Running Processes: $RUNNING_PROCESSES"
}

# Main function
main() {
    check_cpu_usage
    check_mem_usage
    check_disk_usage
    check_processes
}

# Run main function
main

#System Health Monitoring Script:

# Save the script as system_health_monitor.sh.
# Make the script executable: chmod +x system_health_monitor.sh.
# Run the script: ./system_health_monitor.sh.
