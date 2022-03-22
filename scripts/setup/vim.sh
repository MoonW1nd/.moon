#!/bin/bash

if ! hash brew 2>/dev/null
then
    echo 'brew is not install or is not in $PATH'
    exit 1
fi

# Python nvim providers
pip3 install pynvim
pip install pynvim

# install useful stuff with brew

brew update

brew upgrade

# Lua
brew install ninja
brew install luarocks

luarocks install --server=https://luarocks.org/dev luaformatter
luarocks install luacheck
brew install efm-langserver

## TMUX

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Scripts
brew install tmux-mem-cpu-load
