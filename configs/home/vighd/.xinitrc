#!/bin/bash

# Remap fonts
xset +fp ~/.fonts/misc/
xset fp rehash

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
[[ $(date '+%H') -gt 20 ]] && xbacklight -set 10 &
#exec xset r rate 190 35 &
exec setxkbmap -option caps:none &
exec unclutter -idle 1 -jitter 2 -root &
exec udiskie -T -N &
exec nitrogen --restore &
exec dwm-statusbar &
exec dwm
