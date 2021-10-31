#!/bin/bash

pomodoro_status=$(pomodoro status --format "🍅[%c] %r")

if test -z "$pomodoro_status"
then
   echo "🍅 not started"
else
   echo "$pomodoro_status"
fi
