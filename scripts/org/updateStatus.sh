#!/usr/bin/env bash

# Обновление рабочего дашборда.

OLDIFS="$IFS"
IFS=$'\n' # bash specific

inComment=false
nextName=false

TITLE="\e[1;38;5;33m"
GREEN_COLOR="\e[38;5;28m"
YELLOW_COLOR="\e[38;5;172m"
REVIEW="\e[38;5;36m"
END_COLOR="\e[0m"

cd $HOME/Documents/develop/work/arcadia/


meta_doc="$(head -n 9 ~/org/notes/work/status.norg)\n\n"

meta_doc+="*Work status panel*\n"

meta_doc+="\n* Task board\n"

is_first_header=true

for line in $(printf '%s\n' "$(moontool info)")
do
    if [[ $line =~ "^$" ]]; then
        continue
    fi

    if [[ "$line" =~ ^[A-Z]+-[[:digit:]]+[[:space:]].+ ]]; then
        ticket_number=$(echo $line | cut -d ' ' -f 1)
        tracker_url="$TRACKER_URL/$ticket_number"

        meta_doc+="  - [$line]{$tracker_url}\n"
    else
        if [ "$is_first_header" != "true" ]; then
            meta_doc+='\n'
        fi

        is_first_header=false

        meta_doc+="** $line\n"
    fi
done

meta_doc+="\n* Need code review\n"

for line in $(printf '%s\n' "$(moontool review)")
do
    pr_number=$(echo $line | cut -d ' ' -f 1)
    pr_author=$(echo $line | cut -d ' ' -f 3)
    pr_description=$(echo $line | cut -d ' ' -f 4-)
    ticket_number=$(echo $pr_description | cut -d ':' -f 1)
    pr_url="https://a.yandex-team.ru/review/$pr_number/details"
    tracker_url="$TRACKER_URL/$ticket_number"

    meta_doc+="  - [$pr_description ($pr_author)]{$pr_url}\n"
    # meta_doc+="  -- [Pull Requst]{$pr_url}\n"
    # meta_doc+="  -- [Ticket]{$tracker_url}\n"
    # meta_doc="${meta_doc}#time.due $(date +%Y-%m-%d)\n- $pr_description ($pr_author) [PR]{$pr_url} [Tiket]{$tracker_url}\n"
done

printf "$meta_doc" > ~/org/notes/work/status.norg

IFS="$OLDIFS"
