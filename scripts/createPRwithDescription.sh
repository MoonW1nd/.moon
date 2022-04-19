#!/usr/bin/env bash
isArcEnv=
ticket=

if [ ! -z "$(arc info 2>/dev/null)" ]; then
    isArcEnv=true
elif [ ! -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
    isArcEnv=false
else
    echo "[WARN] Not supported vcs"
    exit 1
fi

if [ $isArcEnv == true ]; then
    ticket=$(arc info | grep -o -Ee "branch: .*" | cut -d ' ' -f 2 | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')
else
    ticket=$(git symbolic-ref -q HEAD 2>/dev/null | cut -b 12- | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')
fi

echo "Ticket: $ticket"

title=`st-cli issue $ticket -p summary`
echo "Title: $title"

body=`st-cli issue $ticket -p description`
echo "Description:\n$body"

echo -e "## Какую задачу решаем\n$body\n### Комментарии разработчика\n—\n" > ~/.moon/vcs/__pr_body_msg

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
    arc pr create --push -F ~/.moon/vcs/__pr_body_msg
else
    gh pr create -a @me --body="$(cat ~/.moon/vcs/__pr_body_msg)" --title="$title"
fi
