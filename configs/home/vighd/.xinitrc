#!/bin/bash

# Remap fonts
xset +fp ~/.fonts/misc/
xset fp rehash

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
exec setxkbmap -option caps:none &
exec unclutter -idle 1 -jitter 2 -root &
exec udiskie -T -N &
exec nitrogen --restore &
exec xset r rate 200 25 &
exec dwm-statusbar &
exec dwm 2> ~/.dwm.log
