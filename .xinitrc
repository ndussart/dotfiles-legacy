#!/bin/bash
export PATH=${PATH}:/opt/idea-IU-99.18/bin/

xrandr --output DVI-1 --mode 1440x900 --pos 1920x0 --rotate normal --output DVI-0 --mode 1920x1080 --pos 0x0 --rotate normal
 
# Load resources
 
xrdb -merge .Xresources
 
# Set up an icon tray
 
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x191970 --height 12 &
 
# Set the background color
 
nitrogen --restore
 
# Fire up apps

gnome-do &
 
pidgin &
 
xscreensaver -no-splash &

xsetroot -cursor_name left_ptr &

#MX rev tweaks
xbindkeys
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
 
exec xmonad
