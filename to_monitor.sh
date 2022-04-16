#!/usr/bin/env sh

/usr/bin/xrandr -d :0.0\
    --output VGA-1 --mode 1600x900 --rate 75 --primary\
    --output LVDS-1 --off

sudo cpufreq-set -c 0 -g performance
sudo cpufreq-set -c 1 -g performance
sudo cpufreq-set -c 2 -g performance
sudo cpufreq-set -c 3 -g performance

nitrogen --restore
killall -SIGUSR1 conky
