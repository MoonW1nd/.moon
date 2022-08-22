fpath+=~/.zfunc
# clear
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# For share history before tmux pane
HISTSIZE=1000000 # Set your history file to be reasonably huge
HISTTIMEFORMAT="[%F %T %Z]"
HISTFILE=~/.bash_history # Set the filename to save history to

setopt appendhistory #Append history to the history file (no overwriting)
setopt sharehistory #Share history across terminals
setopt incappendhistory #Immediately append to the history file, not just when a term is killed
setopt histverify #Edit a recalled history line before executing
unsetopt nomatch # fix error with open urls

# Append, clear, and read history after each command
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Ignore duplicate commands, and commands that start with spaces
HISTCONTROL='ignoreboth'

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# on go modules
export GO111MODULE=on

# start nvim on edit in terminal
export EDITOR='nvim'

COMPLETION_WAITING_DOTS="true"

plugins=(
    sudo
    copydir
    copyfile
    copybuffer
    aliases
    history
    zsh-autosuggestions
    urltools
    web-search
    vi-mode
    # zsh-completions
    # zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# zsh-completions
# autoload -U compinit && compinit

# Working config for zsh
source $HOME/dotfiles/.work/.zshrc

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Pure theme
ZSH_THEME=""
# ZSH_THEME="spaceship"
DEFAULT_USER=`whoami`

# Load keys and access tokens
if [ -f $HOME/.tokens ]; then
    source $HOME/.tokens
fi

# aliases
alias ls=exa
alias -g Z='| fzf'
alias vim=nvim
alias td=todoist
alias tdat=todoist-add-task
alias cat=ccat
alias oct=$HOME/dotfiles/scripts/openCurrentTicket.sh
alias ot=$HOME/dotfiles/scripts/openTicket.sh
alias ob=$HOME/dotfiles/scripts/openCurrentBranch.sh
alias opr=$HOME/dotfiles/scripts/openPr.sh
alias .cpr=$HOME/dotfiles/scripts/createPRwithDescription.sh
alias .rmt=$HOME/dotfiles/scripts/restartMT.sh
alias vcs=$HOME/dotfiles/scripts/vcs.sh
alias wttr=$HOME/dotfiles/scripts/wttr.sh
alias pms="pomodoro start"
alias pmf="pomodoro finish"
alias pmts="termdown 25m && osascript -e 'display notification \"Time to break\" with title \"Pomodoro\" subtitle \"Finish\" sound name \"piece-of-cake-611\"'"
alias lsrv="live-server --port=1991"
alias ya='$HOME/Documents/develop/work/arcadia/ya'
alias vssh='$HOME/dotfiles/scripts/vssh.sh'

# dir manipulation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias sl='pmset sleepnow'
alias compare='diff -rq'

# vim goodness
alias :sp='test -n "$TMUX" && tmux split-window'
alias :vs='test -n "$TMUX" && tmux split-window -h'
alias :q='exit'

# load scripts
source $HOME/dotfiles/scripts/minimalVimrc.sh
# source $HOME/dotfiles/scripts/todoist.sh
source $HOME/dotfiles/scripts/tracker.sh
source $HOME/dotfiles/scripts/ff.sh
source $HOME/dotfiles/scripts/fl.sh

# command not found plugin
if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi

export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# load edit-command-line widget
autoload -U edit-command-line
zle -N edit-command-line

# bash ctrl-u behaviour
# @see https://stackoverflow.com/questions/4405200/can-i-make-control-u-behavior-be-the-same-for-zsh-as-it-is-for-bash
bindkey '^U' backward-kill-line
bindkey '^Y' yank

# handy key bindings
bindkey "^S" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^P" history-search-backward
bindkey "^N" insert-last-word
bindkey "^Q" push-line-or-edit

# ctrl+v to edit command in vim
bindkey "^v" edit-command-line

# fzf settings
export FZF_DEFAULT_OPTS="--border --prompt=\"λ \" --height 40% --reverse --history=$HOME/.fzf_history --ansi --bind 'ctrl-j:down,ctrl-k:up,ctrl-d:preview-page-down,ctrl-u:preview-page-up'"
export FZF_COMPLETION_OPTS="--preview '(bat --map-syntax js:jsx --theme base16 --color=always {} || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="$FZF_COMPLETION_OPTS "
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!node_modules/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

. ~/dotfiles/utils/z/z.sh

unalias z 2> /dev/null

z() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

export LDFLAGS=-L/opt/local/lib
export ARCH=macOS-arm64

# import core utils
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#Homebrew
export PATH=/opt/homebrew/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/dotfiles/vifm/vifmimg/vifmimg"
export PATH="$HOME/Library/Python/2.7/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export GOPATH=$HOME/go
export GOROOT="/opt/homebrew/Cellar/go/1.18.1/libexec/"
export PATH=$PATH:$GOPATH/bin
export MOON_VIM_PLUGIN_PATH="$HOME/.vim/pack/vendor/start/"

# Fort correct work vifm
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias luamake=$HOME/.config/nvim/lua-language-server/3rd/luamake/luamake

# nvim settings for brew install nvim
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
source ~/dotfiles/scripts/prompt.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# [[ -s"$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
# eval "$(starship init zsh)"
neofetch
# fpath=($fpath "/Users/moonw1nd/.zfunctions")
# autoload -U promptinit; promptinit
# prompt spaceship
