#!/bin/bash
ls -1 /home/jk/.screenlayout/*.sh | rofi -dmenu -p 'Screen Layout:' | xargs -r sh
