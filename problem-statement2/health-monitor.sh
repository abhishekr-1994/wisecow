#!/bin/bash

# Define thresholds for alerts (adjust these as needed)
CPU_THRESHOLD=80     # percentage
MEMORY_THRESHOLD=90  # percentage
DISK_THRESHOLD=90    # percentage
PROCESS_THRESHOLD=500  # number of processes

# Function to check CPU usage
check_cpu() {
    local cpu_usage=$(top -b -n 1 | awk '/^%Cpu/{print 100 - $8}')
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        echo "CPU usage is high: $cpu_usage%" >&2
    fi
}

# Function to check memory usage
check_memory() {
    local memory_usage=$(awk '/MemTotal/{total=$2} /MemFree/{free=$2} END{printf("%.0f", (total-free)/total * 100)}' 
/proc/meminfo)
    if [ $memory_usage -gt $MEMORY_THRESHOLD ]; then
        echo "Memory usage is high: $memory_usage%" >&2
    fi
}

# Function to check disk usage
check_disk() {
    local disk_usage=$(df / | awk '/\// {print $(NF-1)}' | sed 's/%//')
    if [ $disk_usage -gt $DISK_THRESHOLD ]; then
        echo "Disk usage is high: $disk_usage%" >&2
    fi
}

# Function to check number of running processes
check_processes() {
    local process_count=$(ps aux | wc -l)
    if [ $process_count -gt $PROCESS_THRESHOLD ]; then
        echo "Number of running processes is high: $process_count" >&2
    fi
}

# Main function to call checks and output alerts
main() {
    echo "Checking system health..."

    check_cpu
    check_memory
    check_disk
    check_processes

    echo "Health check completed."
}

# Run the main function
main
