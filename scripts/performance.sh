#!/usr/bin/env sh

echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
/home/nikolay/.local/bin/ryzenadj --slow-limit=25000 --stapm-limit=25000 --fast-limit=40000 --tctl-temp=85

sudo tlp-stat -p
