#!/bin/bash

# Remap fonts
#xset +fp ~/.fonts/misc/
#xset fp rehash
xset r rate 250 45

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export WINIT_X11_SCALE_FACTOR=1
eval "$(ssh-agent)"
exec xinput disable "SynPS/2 Synaptics TouchPad" &
#exec xautocfg &
exec setxkbmap -option caps:none &
exec nitrogen --restore &
exec dunst &
exec udiskie -q &
exec dwm-statusbar &
exec dwm
