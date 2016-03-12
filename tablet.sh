#!/bin/bash

mode=($(printf "Normal\nLeft\nRight\nInverted\n" | \
    zenity --list --column=A --hide-header "--separator= "))

if ! test "${mode[0]}" == "Normal"
then
    xinput disable "AT Translated Set 2 keyboard"
    onboard &
else
    xinput enable "AT Translated Set 2 keyboard"
    killall onboard
fi

xrandr --output eDP1 --rotate $(echo ${mode[0]} | tr '[:upper:]' '[:lower:]')
