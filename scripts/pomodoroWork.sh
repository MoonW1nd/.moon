#!/bin/bash

# Start pomodoro track time by current todo.
# TODO: not actual. Rewrite to neorg integration.

timer='25'
select_task_name_command="todoist --namespace --project-namespace list | fzf | sed 's/ \{2,\}/_/g' | cut -d '_' -f 3"

while getopts d: flag
do
    case $flag in
        d) timer="$OPTARG";;
        *) echo "No reasonable options found!";;
    esac
done

pomodoro start "$(eval ${select_task_name_command})" -d=${timer:-25}
termdown "${timer:-25}m" && osascript -e 'display notification "Time to break" with title "Pomodoro" subtitle "Finish" sound name "piece-of-cake-611"'
