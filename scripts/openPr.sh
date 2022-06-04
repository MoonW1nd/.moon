#!/bin/bash

# Fuzzy find pr and open in web browser.

command=

cd $ARCADIA_PATH

if [ ! -z "$(arc info 2>/dev/null)" ]; then
    command=arc
else
    echo "[WARN] Not supported vcs"
    exit 1
fi

pr_id=

if [ "$1" == "-r" ]; then
    # moontool is my secret cli
    pr_id=$(moontool review | fzf | cut -d ' ' -f 1)
else
    pr_id=$($command pr list $@ | tail -n +2 | fzf | cut -d ' ' -f 1)
fi

if [ -z "$pr_id" ]; then
    echo "Not selected Pull Request"
    exit 0
fi

$command pr view $pr_id

