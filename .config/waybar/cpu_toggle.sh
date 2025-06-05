#!/bin/bash

STATE_FILE="/tmp/waybar_cpu_state"
STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "temp")

if [[ "$1" == "toggle" ]]; then
    if [[ "$STATE" == "temp" ]]; then
        echo "usage" > "$STATE_FILE"
    else
        echo "temp" > "$STATE_FILE"
    fi
    exit 0
fi

if [[ "$STATE" == "temp" ]]; then
    TEMP=$(sensors 2>/dev/null | grep -m1 'Package id 0' | awk '{print $4}' | sed 's/+//;s/°C//')
    echo "CPU ${TEMP}°C "
else
    read -r user1 nice1 system1 idle1 iowait1 irq1 softirq1 steal1 guest1 guest_nice1 < <(grep '^cpu ' /proc/stat)
    total1=$((user1 + nice1 + system1 + idle1 + iowait1 + irq1 + softirq1 + steal1))
    idle_total1=$((idle1 + iowait1))
    
    sleep 1
    
    read -r user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 guest2 guest_nice2 < <(grep '^cpu ' /proc/stat)
    total2=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2))
    idle_total2=$((idle2 + iowait2))
    
    total_diff=$((total2 - total1))
    idle_diff=$((idle_total2 - idle_total1))
    
    if [[ $total_diff -eq 0 ]]; then
        USAGE=0
    else
        USAGE=$((100 * (total_diff - idle_diff) / total_diff))
    fi
    
    echo "CPU ${USAGE}% "
fi
