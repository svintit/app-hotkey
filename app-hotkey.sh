#!/bin/bash

APP=$1

if [[ -z "$APP" ]]; then  # Check if command has an app
    printf "\n--> Please follow the command with an application name \n"
else
    if [[ -n $(ps -aux | grep $APP) ]]; then  # Check if app is running
        wmctrl -i -a $(wmctrl -lx | tr '[:upper:]' '[:lower:]' | grep "${APP}" | cut '-d ' -f1)  # Bring to front
    else
        $(compgen -c | grep $APP | head -n 1) > /dev/null  # Start app
    fi
fi
