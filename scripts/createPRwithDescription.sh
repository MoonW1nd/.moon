#!/usr/bin/env bash
isArcEnv=
ticket=
PR_MESSAGE_FILE_PATH=$HOME/.moon/vcs/__pr_body_msg

if [ ! -z "$(arc info 2>/dev/null)" ]; then
    isArcEnv=true
elif [ ! -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
    isArcEnv=false
else
    echo "[WARN] Not supported vcs"
    exit 1
fi

if [ ! -f "$PR_MESSAGE_FILE_PATH" ]; then
    echo "[ERROR] not found file commit message file: $PR_MESSAGE_FILE_PATH"
    echo "Plese create file manualy: $PR_MESSAGE_FILE_PATH"

    exit 1
fi

if [ $isArcEnv == true ]; then
    ticket=$(arc info | grep -o -Ee "branch: .*" | cut -d ' ' -f 2 | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')
else
    ticket=$(git symbolic-ref -q HEAD 2>/dev/null | cut -b 12- | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/')
fi

echo "Ticket: $ticket"

title=`moontool issue $ticket -p summary`
echo "Title: $title"

body=`moontool issue $ticket -p description`
echo "Description:\n$body"

branch_name=$(arc info | grep -o -Ee "branch: .*" | cut -d ' ' -f 2)

# TODO: adapt by git (протухло?)
echo -e "$title\n\n## Какую задачу решаем\n$body\n### Комментарии разработчика\n—\n" | vipe > $PR_MESSAGE_FILE_PATH

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
    arc pr create --push --message="$(cat $PR_MESSAGE_FILE_PATH)" --no-commits
else
    gh pr create -a @me --body="$(cat $PR_MESSAGE_FILE_PATH)" --title="$title"
fi
