#!/usr/bin/env sh

/usr/bin/xrandr -d :0.0\
    --output LVDS-1 --mode 1366x768 --rate 60 --primary\
    --output VGA-1 --off

sudo cpufreq-set -c 0 -g powersave
sudo cpufreq-set -c 1 -g powersave
sudo cpufreq-set -c 2 -g powersave
sudo cpufreq-set -c 3 -g powersave

nitrogen --restore
killall -SIGUSR1 conky
