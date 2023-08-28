#!/usr/bin/env sh

action="$1"
case $action in
  "volume_toggle")
    amixer -q sset Master toggle
    ;;

  "volume_down")
    amixer -q sset Master 5%-
    ;;

  "volume_up")
    amixer -q sset Master 5%+
    ;;

  "brightness_down")
    current_brightness=$( cat /sys/class/backlight/amdgpu_bl0/actual_brightness )
    current_brightness=$((current_brightness - 15))
    if [ $current_brightness -lt 15 ]; then
      current_brightness=15
    fi
    echo $current_brightness | sudo tee /sys/class/backlight/amdgpu_bl0/brightness
    ;;

  "brightness_up")
    current_brightness=$( cat /sys/class/backlight/amdgpu_bl0/actual_brightness )
    current_brightness=$((current_brightness + 15))
    if [ $current_brightness -gt 255 ]; then
      current_brightness=255
    fi
    echo $current_brightness | sudo tee /sys/class/backlight/amdgpu_bl0/brightness
    ;;
esac
