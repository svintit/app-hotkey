#!/bin/bash

APP=$1

function bring-to-front {
    wmctrl -i -a $(wmctrl -lp | tr '[:upper:]' '[:lower:]' | grep "${APP}" | cut '-d ' -f1)

    if [[ $? != 0 ]]; then
        wmctrl -i -a $(wmctrl -lx | tr '[:upper:]' '[:lower:]' | grep "${APP}" | cut '-d ' -f1)
    fi
}

if [[ -z "$APP" ]]; then  # Check if command has an app
    printf "\n--> Please follow the command with an application name \n"
else
    if [[ -n $(pgrep "${APP}") ]]; then  # Check if app is running
        bring-to-front
    elif [[ -n $(ps -aux | grep "${APP}") ]]; then
        bring-to-front
    else
        notify-send "Opening '${APP}'"
        $(compgen -c | grep $APP | head -n 1) > /dev/null  # Start app
    fi
fi
