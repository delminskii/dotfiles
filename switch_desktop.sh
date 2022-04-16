#!/usr/bin/env sh

# solve it naively
current_output=$( xrandr -q | grep -i 'connected primary' | awk '{print $1}')
if [ $current_output = 'LVDS-1' ] ; then
    # switch to full monitor
    /usr/bin/xrandr -d :0.0\
        --output VGA-1 --mode 1600x900 --rate 75 --primary\
        --output LVDS-1 --off

    sudo cpufreq-set -c 0 -g performance
    sudo cpufreq-set -c 1 -g performance
    sudo cpufreq-set -c 2 -g performance
    sudo cpufreq-set -c 3 -g performance
elif [ $current_output = 'VGA-1' ] ; then
    # switch to laptop
    /usr/bin/xrandr -d :0.0\
        --output LVDS-1 --mode 1366x768 --rate 60 --primary\
        --output VGA-1 --off

    sudo cpufreq-set -c 0 -g powersave
    sudo cpufreq-set -c 1 -g powersave
    sudo cpufreq-set -c 2 -g powersave
    sudo cpufreq-set -c 3 -g powersave
fi

nitrogen --restore
killall -SIGUSR1 conky
