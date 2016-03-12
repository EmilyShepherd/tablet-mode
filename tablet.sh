#!/bin/bash

# Ask the user which tablet mode to go into
mode=($( \
    printf "Normal\nLeft\nRight\nInverted\n" | \
    zenity --list --column=A --hide-header "--separator= " \
))

if test -z "$mode"
then
    exit 0
fi

# If we've selected a tablet mode, replace the physical keyboard with an
# onscreen one
if ! test "${mode[0]}" == "Normal"
then
    xinput disable "AT Translated Set 2 keyboard"
    onboard &
# Close the onscreen keyboard and re-enabled the physical one
else
    xinput enable "AT Translated Set 2 keyboard"
    killall -q onboard
fi

# Actually do the flip of the screen, with a lower case version of the
# orientation
xrandr --output eDP1 --rotate $(echo ${mode[0]} | tr '[:upper:]' '[:lower:]')
