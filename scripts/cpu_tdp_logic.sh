#!/usr/bin/env sh


action="$1"
case $action in
  "ac_plug_in")
    sudo /home/nikolay/.local/bin/ryzenadj --slow-limit=25000 --stapm-limit=25000 --fast-limit=40000 --tctl-temp=85
    ;;

  "ac_plug_out")
    sudo /home/nikolay/.local/bin/ryzenadj --slow-limit=8000 --stapm-limit=10000 --fast-limit=12000 --tctl-temp=60
    ;;
esac

date
sudo tlp-stat -p
