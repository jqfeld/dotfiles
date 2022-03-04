#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run ibus-daemon -Rd
run blueman-applet
run seafile-applet
run cbatticon
run light-locker
