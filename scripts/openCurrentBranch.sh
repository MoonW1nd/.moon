#!/bin/bash

# Open current branch in web.

isArcEnv=

if [ ! -z "$(arc info 2>/dev/null)" ]; then
    isArcEnv=true
elif [ ! -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
    isArcEnv=false
else
    echo "[WARN] Not supported vcs"
    exit 1
fi

if [ $isArcEnv == true ]; then
    arc pr view
else
    get_branch_name_from_ref='sed "s/refs\/heads\///"'
    branch_name=$(git symbolic-ref -q HEAD 2>/dev/null | eval ${get_branch_name_from_ref})
    repository_url=$(git config --get remote.origin.url | sed -E -e 's+https://|http://|^git@|.git$++g' | sed 's+:+/+g' | sed 's+^+http://+')

    if remote=$(git config --get "branch.${branch_name}.remote"); then
        remote_branch_name="$(git config --get branch.${branch_name}.merge | eval ${get_branch_name_from_ref})"
        open "$repository_url/pull/$remote_branch_name"
    else
        echo "Remote branch not found"
    fi
fi

