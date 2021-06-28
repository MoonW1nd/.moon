select_items_command="todoist --namespace --project-namespace list | fzf | cut -d ' ' -f 1 | tr '\n' ' '"
selct_projects_command="todoist --project-namespace projects | fzf | head -n1 | cut -d ' ' -f 1"
select_task_name_command="todoist --namespace --project-namespace list | fzf | sed 's/ \{2,\}/_/g' | cut -d '_' -f 3"

function insert-in-buffer () {
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

# todoist find item
function fzf-todoist-item () {
    local SELECTED_ITEMS="$(eval ${select_items_command})"
    insert-in-buffer $SELECTED_ITEMS
}
zle -N fzf-todoist-item

# todoist find item name
function fzf-todoist-item-name () {
    local SELECTED_ITEMS="$(eval ${select_task_name_command})"
    insert-in-buffer $SELECTED_ITEMS
}
zle -N fzf-todoist-item-name
bindkey "^xtn" fzf-todoist-item-name

# todoist find project
function fzf-todoist-project () {
    local SELECTED_PROJECT="$(todoist --project-namespace projects | fzf | head -n1 | cut -d ' ' -f 1)"
    insert-in-buffer "${SELECTED_PROJECT}" "-P"
}
zle -N fzf-todoist-project
bindkey "^xtp" fzf-todoist-project

# todoist find labels
function fzf-todoist-labels () {
    local SLECTED_LABELS="$(todoist labels | fzf | cut -d ' ' -f 1 | tr '\n' ',' | sed -e 's/,$//')"
    insert-in-buffer "${SELECTED_LABELS}" "-L"
}
zle -N fzf-todoist-labels
bindkey "^xtl" fzf-todoist-labels

# todoist select date
function fzf-todoist-date () {
    date -v 1d &>/dev/null
    if [ $? -eq 0 ]; then
        # BSD date option
        OPTION="-v+#d"
    else
        # GNU date option
        OPTION="-d # day"
    fi

    local SELECTED_DATE="$(seq 0 30 | xargs -I# date $OPTION '+%d/%m/%Y %a' | fzf | cut -d ' ' -f 1)"
    insert-in-buffer "'${SELECTED_DATE}'" "-d"
}
zle -N fzf-todoist-date
bindkey "^xtd" fzf-todoist-date

function todoist-exec-with-select-task () {
    if [ -n "$2" ]; then
        BUFFER="todoist $1 $(echo "$2" | tr '\n' ' ')"
        CURSOR=$#BUFFER
        zle accept-line
    fi
}

# todoist close
function fzf-todoist-close() {
    local SELECTED_ITEMS="$(eval ${select_items_command})"
    todoist-exec-with-select-task close $SELECTED_ITEMS
}
zle -N fzf-todoist-close
bindkey "^xtc" fzf-todoist-close

# todoist delete
function fzf-todoist-delete() {
    local SELECTED_ITEMS="$(eval ${select_items_command})"
    todoist-exec-with-select-task delete $SELECTED_ITEMS
}
zle -N fzf-todoist-delete
bindkey "^xtk" fzf-todoist-delete

# todoist open
function fzf-todoist-open() {
    local SELECTED_ITEMS="$(eval ${select_items_command})"
    todoist-exec-with-select-task "show --browse" $SELECTED_ITEMS
}
zle -N fzf-todoist-open
bindkey "^xto" fzf-todoist-open

# todoist create task
function todoist-add() {
    local TICKET_NAME=$(git symbolic-ref -q HEAD 2>/dev/null | cut -b 12- | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')
    local SELECTED_PROJECT="$(eval ${selct_projects_command})"

    todoist add -P=$SELECTED_PROJECT "$1"
}
zle -N todoist-add

# todoist create ticket task
function todoist-add-task() {
    local TICKET_NAME=$(git symbolic-ref -q HEAD 2>/dev/null | cut -b 12- | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')
    local NAMESPACE=''

    if [ -n "$TICKET_NAME" ]
    then
        local TICKET_URL="$TRACKER_URL/$TICKET_NAME"
        NAMESPACE="[$TICKET_NAME]($TICKET_URL): "
    fi

    local SELECTED_PROJECT="$(eval ${selct_projects_command})"
    todoist add -P=$SELECTED_PROJECT "$NAMESPACE$1" 
}
zle -N todoist-add-task
bindkey "^xtt" todoist-add-task
