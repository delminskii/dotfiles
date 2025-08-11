#!/usr/bin/env sh

# toggle
case $( warp-cli status | grep -i status | cut -d' ' -f3 | tr '[:upper:]' '[:lower:]' ) in
  'disconnected')
    warp-cli connect && echo 'Connecting' && sleep 1
    watch -n 0.5 'warp-cli status'
    ;;

  'connected')
    warp-cli disconnect && echo 'Disconnected' && sleep 1
    ;;

  'connecting')
    watch -n 0.5 'warp-cli status'
    ;;
esac
