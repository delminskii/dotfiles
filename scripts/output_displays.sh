#!/usr/bin/env sh
# $1 = 0 - notebook only (1680x1050 @ 90Hz) (default)
# $1 = 1 - 4k monitor only (3440x1440 @ 100Hz)
# $1 = 2 - both notebook (left) & 4k monitor (right)

notebook_display=$( xrandr | grep -i "edp.* connected" | cut -d' ' -f1)
bigscreen_display=$( xrandr | grep -i "hdmi.* connected" | cut -d' ' -f1 )
# NOTEBOOK_DISPLAY="eDP"
# NOTEBOOK_DISPLAY="eDP-1"
# NOTEBOOK_DISPLAY_CANDIDATES=("eDP" "eDP-1")
NOTEBOOK_RATE=90
NOTEBOOK_MODE=1680x1050

# BIGSCREEN_DISPLAY="HDMI-A-0"
# BIGSCREEN_DISPLAY="HDMI-1"
# BIGSCREEN_DISPLAY_CANDIDATES=("HDMI-A-0" "HDMI-1")
BIGSCREEN_RATE=100
BIGSCREEN_MODE=3440x1440

cmd=
case $1 in
  0)
    cmd="xrandr --output $notebook_display --primary --mode $NOTEBOOK_MODE --rate $NOTEBOOK_RATE --output $bigscreen_display --off"
    ;;
  1)
    cmd="xrandr --output $bigscreen_display --primary --mode $BIGSCREEN_MODE --rate $BIGSCREEN_RATE --output $notebook_display --off"
    ;;
  2)
    cmd="xrandr --output $bigscreen_display --primary --mode $BIGSCREEN_MODE --pos 1680x0 --rate $BIGSCREEN_RATE --output $notebook_display --mode $NOTEBOOK_MODE --pos 0x390 --rate $NOTEBOOK_RATE --left-of $bigscreen_display"
    ;;
esac

if [[ -n $cmd ]]; then
  echo $cmd
  $cmd
fi
