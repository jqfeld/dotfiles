#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run ibus-daemon -drxR
run nm-applet
run blueman-applet
run seafile-applet
# run syncthing
run cbatticon
run light-locker
run udiskie
run picom

# run feh --bg-scale ~/.config/awesome/wallpaper_rainy.jpg
# run conky
