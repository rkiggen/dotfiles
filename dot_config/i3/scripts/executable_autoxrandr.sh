#!/bin/sh
#requires:
#parameters:
# - monitor: regex for finding the laptop display
# - direction: --left-of | --right-of
#description:
# discover the laptop display (lvds) with a regular expression
# and move all other displays to the left or right (direction) of the laptop display
# the screen which is the furthest to the left or right will be the primary screen

monitor='^eDP.*$' # 
direction='--left-of'

for output in $(xrandr | grep '\Wconnected' | awk '{ print $1 }'); do
    if [[ $output =~ $monitor ]]; then
            lvds=$output
    fi
done	

for output in $(xrandr | grep '\Wconnected' | awk '{ print $1 }'); do
    if [[ ! $output =~ $monitor ]]; then
       xrandr --output $lvds --auto --output $output --pos 0x0 --auto \
              $direction $lvds --primary
    fi
done
