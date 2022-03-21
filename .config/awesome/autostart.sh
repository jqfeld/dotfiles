#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run ibus-daemon -drxR
run blueman-applet
run seafile-applet
run cbatticon
run light-locker
run udiskie
