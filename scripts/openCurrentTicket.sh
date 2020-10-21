function open-current-ticket() {
    ticket_name=$(git symbolic-ref -q HEAD 2>/dev/null | cut -b 12- | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')

    if [ -n "$ticket_name" ]
    then
        open "$TRACKER_URL/$ticket_name"
    else
        echo "Ticket not found"
    fi
}
