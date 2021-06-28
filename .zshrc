# export PATH=$HOME/bin:/usr/local/bin:$PATH

# For share history before tmux pane
shopt -s histappend # Append to history, don't overwrite it
shopt -s histreedit # Re-edit a history substitution line if it failed
shopt -s histverify # # Edit a recalled history line before executing
HISTFILE=~/.bash_history # Set the filename to save history to
HISTSIZE=1000000 # Set your history file to be reasonably huge
HISTTIMEFORMAT="[%F %T %Z]"

# Append, clear, and read history after each command
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# Ignore duplicate commands, and commands that start with spaces
HISTCONTROL='ignoreboth'

# Path to your oh-my-zsh installation.
export ZSH="/Users/moonw1nd/.oh-my-zsh"
# export PATH=/anaconda3/bin:$PATH
# export PATH=/Users/moonw1nd/Library/Python/3.7/bin:$PATH
export FZF_DEFAULT_OPTS="--border --height 40% --reverse --history=$HOME/.fzf_history --ansi"

# on go modules
export GO111MODULE=on

export EDITOR='nvim'

alias cat=ccat

alias ya=~/.yatool/ya

alias tvmknife='ya tool tvmknife'

alias ot=open-current-ticket
alias ob=open-current-branch
alias pms="pomodoro start"
alias pmf="pomodoro finish"
alias pmts="termdown 25m && osascript -e 'display notification \"Time to break\" with title \"Pomodoro\" subtitle \"Finish\" sound name \"piece-of-cake-611\"'"

alias ctags="`brew --prefix`/bin/ctags"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Pure theme
ZSH_THEME=""
DEFAULT_USER=`whoami`
autoload -U promptinit; promptinit
prompt spaceship

if [ -f $HOME/.tokens ]; then
    source .tokens # Не светим токенами, если шарим конфиг шелла между тачками
fi

# aliases
alias ls=exa
alias -g Z='| fzf'
alias vim=nvim
alias td=todoist
alias tdat=todoist-add-task

# plugins
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/dotfiles/scripts/todoist.sh
source $HOME/dotfiles/scripts/pomodoroWork.sh
source $HOME/dotfiles/scripts/openCurrentTicket.sh
source $HOME/dotfiles/scripts/openCurrentBranch.sh

# command not found plugin
if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_COMPLETION_OPTS="--preview '(bat --map-syntax js:jsx --theme base16 --color=always {} || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="$FZF_COMPLETION_OPTS"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!node_modules/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# ff - Find any folder and cd to selected directory
ff() {
 local dir
 dir=$(fd ${1:-.} 2> /dev/null | fzf +m) &&
 cd "$dir"
}

# lf- List folders and cd to selected directory
lf() {
 local dir
 dir=$(ls -a ${1:-.} 2> /dev/null | fzf +m) &&
 cd "$dir"
}

vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi

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
