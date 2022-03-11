#!/bin/bash

# Remap fonts
#xset +fp ~/.fonts/misc/
#xset fp rehash

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
eval "$(ssh-agent)"
xset r rate 400 40
exec xinput disable "SynPS/2 Synaptics TouchPad" &
exec setxkbmap -option caps:none &
exec udiskie -T -N &
exec nitrogen --restore &
exec dunst &
exec dwm-statusbar &
exec dwm
