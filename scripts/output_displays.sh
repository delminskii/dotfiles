#!/usr/bin/env sh
# $1 = 0 - notebook only (1680x1050 @ 90Hz) (default)
# $1 = 1 - 4k monitor only (3440x1440 @ 100Hz)
# $1 = 2 - both notebook (left) & 4k monitor (right)

NOTEBOOK_DISPLAY=eDP-1
NOTEBOOK_RATE=90
NOTEBOOK_MODE=1680x1050

BIGSCREEN_DISPLAY="HDMI-1"
BIGSCREEN_RATE=100
BIGSCREEN_MODE=3440x1440

cmd=
case $1 in
  0)
    cmd="xrandr --output $NOTEBOOK_DISPLAY --primary --mode $NOTEBOOK_MODE --rate $NOTEBOOK_RATE --output $BIGSCREEN_DISPLAY --off"
    ;;
  1)
    cmd="xrandr --output $BIGSCREEN_DISPLAY --primary --mode $BIGSCREEN_MODE --rate $BIGSCREEN_RATE --output $NOTEBOOK_DISPLAY --off"
    ;;
  2)
    cmd="xrandr --output $BIGSCREEN_DISPLAY --primary --mode $BIGSCREEN_MODE --pos 1680x0 --rate $BIGSCREEN_RATE --output $NOTEBOOK_DISPLAY --mode $NOTEBOOK_MODE --pos 0x390 --rate $NOTEBOOK_RATE --left-of $BIGSCREEN_DISPLAY"
    ;;
esac

if [[ $cmd ]]; then
  echo $cmd
  $cmd
fi
