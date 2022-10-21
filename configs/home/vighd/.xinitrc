#!/bin/bash

# Remap fonts
#xset +fp ~/.fonts/misc/
#xset fp rehash

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export WINIT_X11_SCALE_FACTOR=1
eval "$(ssh-agent)"
xset r rate 400 40
exec xinput disable "SynPS/2 Synaptics TouchPad" 2>&1 &
exec setxkbmap -option caps:none 2>&1 &
exec udiskie -T -N 2>&1 &
exec nitrogen --restore 2>&1 &
exec dunst 2>&1 &
#exec xcalib "$HOME/.colors/x260_innolux.icm" 2>&1 &
exec dwm-statusbar &
exec dwm 2>&1
