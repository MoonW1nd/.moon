#!/usr/bin/env bash

selected=`cat ~/dotfiles/.tmux-cht-languages ~/dotfiles/.tmux-cht-command | fzf --prompt="λ "`

if [[ -z $selected ]]; then
    exit 0
fi

read -p "$selected/λ " query

# TODO: add support open in minimal vim configuration

if grep -qs "$selected" ~/dotfiles/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "echo \"curl cht.sh/$selected~$query\" & curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi
