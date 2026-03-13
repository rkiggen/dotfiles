#!/usr/bin/env bash
#requires:
# 'xprintidle' for inactivity check (in ms)
# 'xdotool' to move the mouse pointer or send a key
#
scriptpath="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
artfile="$scriptpath/coffee.ascii"
if [ -e "$artfile" ]; then
	cat $artfile
fi

echo "Taking a coffee break"
echo "Press ctrl+c to start working again..."

while :; do
    if  [ $(xprintidle) -gt 5000 ]
    then
        echo "." | xargs xdotool key type > /dev/null;
    fi

    sleep 30
done
