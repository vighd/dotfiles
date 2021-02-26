#!/bin/bash

# Remap fonts
#xset +fp ~/.fonts/misc/
#xset fp rehash

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
eval $(ssh-agent)
exec xset r rate 350 30 &
exec xinput disable "SynPS/2 Synaptics TouchPad" &
exec setxkbmap -option caps:none &
exec unclutter -idle 1 -jitter 2 -root &
exec udiskie -T -N &
exec nitrogen --restore &
#exec sudo tpfix &
exec dwm-statusbar &
exec dwm
