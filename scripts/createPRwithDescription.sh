#!/usr/bin/env bash
ticket=`git tname`
echo "Ticket: $ticket"

title=`st-cli issue $ticket -p summary`
echo "Title: $title"

body=`st-cli issue $ticket -p description`
echo "Description:\n$body"

echo -e "## Какую задачу решаем\n$body\n### Комментарии разработчика\n—\n" > ~/.gh_body_msg

gh pr create -a @me --body="$(cat ~/.gh_body_msg)" --title="$title"
