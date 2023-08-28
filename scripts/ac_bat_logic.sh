#!/bin/bash

# https://4pda.to/forum/index.php?showtopic=1052708&view=findpost&p=124403250
STATUS=$( cat /sys/class/power_supply/BAT0/status )
if [[ $STATUS == "Discharging" ]]; then
  echo "power" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
  echo 1 | sudo tee /sys/module/snd_hda_intel/parameters/power_save
  echo 1500 | sudo tee /proc/sys/vm/dirty_writeback_centisecs
else
  echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
fi

cat /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
date
sudo tlp-stat -p
