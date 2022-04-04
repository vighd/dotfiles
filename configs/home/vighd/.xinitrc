#!/bin/bash

# Remap fonts
#xset +fp ~/.fonts/misc/
#xset fp rehash

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export WINIT_X11_SCALE_FACTOR=1
eval "$(ssh-agent)"
xset r rate 400 40
exec xinput disable "SynPS/2 Synaptics TouchPad" &
exec xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Profile Enabled" 0, 1 &
exec xinput --set-prop 'TPPS/2 IBM TrackPoint' 'libinput Accel Speed' 0.5 &
exec setxkbmap -option caps:none &
exec udiskie -T -N &
exec nitrogen --restore &
exec dunst &
exec xcalib $HOME/.colors/x260_innolux.icm &
exec dwm-statusbar &
exec dwm
