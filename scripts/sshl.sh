#!/bin/bash

$HOME/dotfiles/scripts/vssh.sh -t "tmux attach" $REMOTE_DEV_SERVER -A $@

if [ "$?" = "1" ]; then
    $HOME/dotfiles/scripts/vssh.sh -t "cd ./affiliate_moonw1nd && tmux new" $REMOTE_DEV_SERVER -A $@
fi
