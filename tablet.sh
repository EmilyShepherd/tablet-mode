!/bin/bash

mode=($(printf "Normal\nLeft\nRight\nInverted\n" | \
    zenity --list --column=A --hide-header "--separator= "))

if ! test "${mode[0]}" == "Normal"
then
    xinput disable "AT Translated Set 2 keyboard"
    onboard &
 
    xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 0, 0
    xinput set-prop "ELAN Touchscreen" "Evdev Axes Swap" 0
else
    xinput enable "AT Translated Set 2 keyboard"
    killall onboard

    case "${mode[0]}" in
        Right)
            xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 1, 0
            xinput set-prop "ELAN Touchscreen" "Evdev Axes Swap" 1
            ;;
        Inverted)
            xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 1, 1
            xinput set-prop "ELAN Touchscreen" "Evdev Axes Swap" 0
            ;;
        Right)
            xinput set-prop "ELAN Touchscreen" "Evdev Axis Inversion" 0, 1
            xinput set-prop "ELAN Touchscreen" "Evdev Axes Swap" 1
            ;;
    esac
fi

xrandr --output eDP1 --rotate $(echo ${mode[0]} | tr '[:upper:]' '[:lower:]')
