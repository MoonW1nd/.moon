#!/bin/bash

# Script for open issue ticket by parse branch name.

isArcEnv=
ticket_name=

if [ ! -z "$(arc info 2>/dev/null)" ]; then
    isArcEnv=true
elif [ ! -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
    isArcEnv=false
else
    echo "[WARN] Not supported vcs"
    exit 1
fi

if [ $isArcEnv == true ]; then
    ticket_name=$(arc info | grep -o -Ee "branch: .*" | cut -d ' ' -f 2 | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')
else
    ticket_name=$(git symbolic-ref -q HEAD 2>/dev/null | cut -b 12- | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')
fi

if [ -n "$ticket_name" ]; then
    open "$TRACKER_URL/$ticket_name"
else
    echo "Ticket not found"
fi
