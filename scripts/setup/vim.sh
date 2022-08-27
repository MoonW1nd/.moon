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

function install_lsp() {
    local command=$2
    local name=$1

    $command \
    && echo "✅ $name lsp installed" \
    || echo "❗️ Could not installed $name lsp";
}

function install_sumneko_lua_ls() {
    echo 'Install lua-language-server to nvim folder...'
    cd ~/.config/nvim
    git clone https://github.com/sumneko/lua-language-server

    echo 'Install lua-language-server submodules...'
    cd lua-language-server
    git submodule update --init --recursive

    echo 'Build luamake...'
    cd ./3rd/luamake
    ninja -f ./compile/ninja/macos.ninja

    echo 'Rebuild luamake...'
    cd ../..
    ./3rd/luamake/luamake rebuild
}

# LSP
# install_lsp 'bash' 'npm i -g bash-language-server'
install_lsp 'cssls, eslint, html' 'npm i -g vscode-langservers-extracted'
install_lsp 'efm' 'brew install efm-langserver'
install_lsp 'gopls' 'go install golang.org/x/tools/gopls@latest'
install_lsp 'pyright' 'npm install -g pyright'
install_lsp 'stylelint' 'npm i -g stylelint-lsp'
install_lsp 'svelte' 'npm install -g svelte-language-server'
install_lsp 'ts' 'npm install -g typescript typescript-language-server'
install_lsp 'yaml' 'yarn global add yaml-language-server'
install_lsp 'vim' 'npm install -g vim-language-server'
install_sumneko_lua_ls
