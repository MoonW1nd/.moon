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
export ZSH="/Users/$USER/.oh-my-zsh"

# on go modules
export GO111MODULE=on

# start nvim on edit in terminal
export EDITOR='nvim'

COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    vi-mode
    zsh-autosuggestions
    urltools
    web-search
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

# zsh-completions
autoload -U compinit && compinit

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Pure theme
ZSH_THEME=""
DEFAULT_USER=`whoami`
autoload -U promptinit; promptinit
prompt spaceship

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
alias ot=open-current-ticket
alias ob=open-current-branch
alias pms="pomodoro start"
alias pmf="pomodoro finish"
alias pmts="termdown 25m && osascript -e 'display notification \"Time to break\" with title \"Pomodoro\" subtitle \"Finish\" sound name \"piece-of-cake-611\"'"

# load scripts
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/dotfiles/scripts/todoist.sh
source $HOME/dotfiles/scripts/ff.sh
source $HOME/dotfiles/scripts/fl.sh
source $HOME/dotfiles/scripts/pomodoroWork.sh
source $HOME/dotfiles/scripts/openCurrentTicket.sh
source $HOME/dotfiles/scripts/openCurrentBranch.sh

# command not found plugin
if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi

export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# fzf settings
export FZF_DEFAULT_OPTS="--border --height 40% --reverse --history=$HOME/.fzf_history --ansi"
export FZF_COMPLETION_OPTS="--preview '(bat --map-syntax js:jsx --theme base16 --color=always {} || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="$FZF_COMPLETION_OPTS"
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


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/Library/Python/2.7/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

alias luamake=$HOME/.config/nvim/lua-language-server/3rd/luamake/luamake
