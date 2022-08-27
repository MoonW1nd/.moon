#!/bin/bash

# ========================================================
# by default tun with `./scripts/setup/create_sym_links.sh`
#
# to run a specific function, run scripts using
# `SKIP_ALL=1 RUN_setup_dock=1 ./scripts/setup/create_sym_links.sh`
# ========================================================

function setup_karabiner_settings() {
    ln -s ~/dotfiles/karabiner/* ~/.config/karabiner/assets/complex_modifications/ \
        && echo '✅ Karabiner prefernces symlink created' \
        || echo '❗️ Could not create symlink to Karabiner settings';
}

function setup_vimrc() {
    ln -s ~/dotfiles/.vimrc ~/.vimrc \
        && echo '✅ .vimrc prefernces symlink created' \
        || echo '❗️ Could not create symlink to .vimrc';

    ln -s ~/dotfiles/.ideavimrc ~/.ideavimrc \
        && echo '✅ .ideavimrc prefernces symlink created' \
        || echo '❗️ Could not create symlink to .ideavimrc';
}

function setup_zshrc() {
    ln -s ~/dotfiles/.zshrc ~/.zshrc \
        && echo '✅ .zshrc prefernces symlink created' \
        || echo '❗️ Could not create symlink to .zshrc';
}

function setup_skhdrc() {
    ln -s ~/dotfiles/skhdrc ~/.skhdrc \
        && echo '✅ .skhdrc prefernces symlink created' \
        || echo '❗️ Could not create symlink to .skhdrc';
}

function setup_tmux_conf() {
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf \
        && echo '✅ .tmux.conf prefernces symlink created' \
        || echo '❗️ Could not create symlink to .tmux.conf';
}

function setup_nvim() {
    ln -s ~/dotfiles/nvim/.config/nvim ~/.config/nvim \
        && echo '✅ nvim prefernces symlink created' \
        || echo '❗️ Could not create symlink to nvim';
}

function setup_git() {
    ln -s ~/dotfiles/.gitconfig ~/.gitconfig \
        && echo '✅ nvim prefernces symlink created' \
        || echo '❗️ Could not create symlink to nvim';
}

function setup_alacritty() {
    ln -s ~/dotfiles/.alacritty.yml ~/.alacritty.yml \
        && echo '✅ .alacritty.yml prefernces symlink created' \
        || echo '❗️ Could not create symlink to .alacritty.yml';
}

function setup_vifm() {
    rm -rf ~/.config/vifm/colors

    git clone https://github.com/vifm/vifm-colors ~/.config/vifm/colors

    ln -s ~/dotfiles/vifm/vifmrc ~/.config/vifm/vifmrc \
        && echo '✅ Vifm prefernces symlink created' \
        || echo '❗️ Could not create symlink to vifmrc';

    ln ~/dotfiles/vifm/colors/moonw1nd.vifm ~/.config/vifm/colors/moonw1nd.vifm \
        && echo '✅ Copy theme vifm' \
        || echo '❗️ Could not copy theme vifm.';
}

if [[ "$SKIP_ALL" == "1" ]]; then
    echo "skipped all"

    [[ "$RUN_setup_alacritty" == "1" ]] && setup_alacritty;
    [[ "$RUN_setup_git" == "1" ]] && setup_git;
    [[ "$RUN_setup_tmux_conf" == "1" ]] && setup_tmux_conf;
    [[ "$RUN_setup_vimrc" == "1" ]] && setup_vimrc;
    [[ "$RUN_setup_karabiner_settings" == "1" ]] && setup_karabiner_settings;
    [[ "$RUN_setup_zshrc" == "1" ]] && setup_zshrc;
    [[ "$RUN_setup_skhdrc" == "1" ]] && setup_skhdrc;
    [[ "$RUN_setup_nvim" == "1" ]] && setup_nvim;
    [[ "$RUN_setup_vifm" == "1" ]] && setup_vifm;
else
    echo "running all scripts"

    setup_alacritty;
    setup_git;
    setup_tmux_conf;
    setup_vimrc;
    setup_karabiner_settings;
    setup_zshrc;
    setup_skhdrc;
    setup_nvim;
    setup_vifm;
fi
