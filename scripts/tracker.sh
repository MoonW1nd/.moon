select_tracker_ticket_number="moontool info -o | fzf | cut -d ' ' -f 2"

function insert-in-buffer () {
    echo "lbuffer $LBUFFER"
    echo "rbuffer $RBUFFER"

    if [ -n "$1" ]; then
        local new_left=""

        echo "$LBUFFER"

        if [ -n "$LBUFFER" ]; then
            new_left="${new_left}${LBUFFER} "
        fi
        if [ -n "$2" ]; then
            new_left="${new_left}${2} "
        fi
        new_left="${new_left}$1"
        BUFFER=${new_left}${RBUFFER}
        CURSOR=${#new_left}
    fi
}

# tracker select ticket name
function fzf-tracker-ticket-number () {
    local SELECTED_ITEMS="$(eval ${select_tracker_ticket_number})"
    insert-in-buffer $SELECTED_ITEMS
}

zle -N fzf-tracker-ticket-number
bindkey "^xst" fzf-tracker-ticket-number
