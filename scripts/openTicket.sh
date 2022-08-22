#!/bin/bash

ticket_name=$(moontool info -o | fzf | sed 's/ \{1,\}/_/g' | cut -d '_' -f 2)

if [ -n "$ticket_name" ]; then
    open "$TRACKER_URL/$ticket_name"
else
    echo "Ticket not found"
fi
