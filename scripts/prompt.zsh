# ZSH has a quirk where `preexec` is only run if a command is actually run (i.e
# pressing ENTER at an empty command line will not cause preexec to fire). This
# can cause timing issues, as a user who presses "ENTER" without running a command
# will see the time to the start of the last command, which may be very large.

# To fix this, we create STARSHIP_START_TIME upon preexec() firing, and destroy it
# after drawing the prompt. This ensures that the timing for one command is only
# ever drawn once (for the prompt immediately after it is run).

zmodload zsh/parameter  # Needed to access jobstates variable for STARSHIP_JOBS_COUNT

# Defines a function `__starship_get_time` that sets the time since epoch in millis in STARSHIP_CAPTURED_TIME.
if [[ $ZSH_VERSION == ([1-4]*) ]]; then
    # ZSH <= 5; Does not have a built-in variable so we will rely on Starship's inbuilt time function.
    __starship_get_time() {
        STARSHIP_CAPTURED_TIME=$(::STARSHIP:: time)
    }
else
    zmodload zsh/datetime
    zmodload zsh/mathfunc
    __starship_get_time() {
        (( STARSHIP_CAPTURED_TIME = int(rint(EPOCHREALTIME * 1000)) ))
    }
fi


# The two functions below follow the naming convention `prompt_<theme>_<hook>`
# for compatibility with Zsh's prompt system. See
# https://github.com/zsh-users/zsh/blob/2876c25a28b8052d6683027998cc118fc9b50157/Functions/Prompts/promptinit#L155

# Runs before each new command line.
prompt_starship_precmd() {
    # Save the status, because commands in this pipeline will change $?
    STARSHIP_CMD_STATUS=$? STARSHIP_PIPE_STATUS=(${pipestatus[@]})

    # Compute cmd_duration, if we have a time to consume, otherwise clear the
    # previous duration
    if (( ${+STARSHIP_START_TIME} )); then
        __starship_get_time && (( STARSHIP_DURATION = STARSHIP_CAPTURED_TIME - STARSHIP_START_TIME ))
        unset STARSHIP_START_TIME
    else
        unset STARSHIP_DURATION
    fi

    # Use length of jobstates array as number of jobs. Expansion fails inside
    # quotes so we set it here and then use the value later on.
    STARSHIP_JOBS_COUNT=${#jobstates}
}

# Runs after the user submits the command line, but before it is executed.
prompt_starship_preexec() {
    __starship_get_time && STARSHIP_START_TIME=$STARSHIP_CAPTURED_TIME
}

# Add hook functions
autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_starship_precmd
add-zsh-hook preexec prompt_starship_preexec

# Set up a function to redraw the prompt if the user switches vi modes
starship_zle-keymap-select() {
    zle reset-prompt
}

## Check for existing keymap-select widget.
# zle-keymap-select is a special widget so it'll be "user:fnName" or nothing. Let's get fnName only.
__starship_preserved_zle_keymap_select=${widgets[zle-keymap-select]#user:}
if [[ -z $__starship_preserved_zle_keymap_select ]]; then
    zle -N zle-keymap-select starship_zle-keymap-select;
else
    # Define a wrapper fn to call the original widget fn and then Starship's.
    starship_zle-keymap-select-wrapped() {
        $__starship_preserved_zle_keymap_select "$@";
        starship_zle-keymap-select "$@";
    }
    zle -N zle-keymap-select starship_zle-keymap-select-wrapped;
fi

__starship_get_time && STARSHIP_START_TIME=$STARSHIP_CAPTURED_TIME

export STARSHIP_SHELL="zsh"


# __SPACESHIP_VIM_MODE="N"
# ZVM_CURSOR_STYLE_ENABLED=false
#
# function zvm_after_select_vi_mode() {
#   case $ZVM_MODE in
#     $ZVM_MODE_NORMAL)
#         __SPACESHIP_VIM_MODE="N"
#     ;;
#     $ZVM_MODE_INSERT)
#         __SPACESHIP_VIM_MODE="I"
#     ;;
#     $ZVM_MODE_VISUAL)
#         __SPACESHIP_VIM_MODE="V"
#     ;;
#     $ZVM_MODE_VISUAL_LINE)
#         __SPACESHIP_VIM_MODE="V"
#     ;;
#     $ZVM_MODE_REPLACE)
#         __SPACESHIP_VIM_MODE="R"
#     ;;
#   esac
# }

function spaceship_section() {
  local color prefix content suffix
  [[ -n $1 ]] && color="%F{$1}"  || color="%f"
  [[ -n $2 ]] && prefix="$2"     || prefix=""
  [[ -n $3 ]] && content="$3"    || content=""
  [[ -n $4 ]] && suffix="$4"     || suffix=""

  [[ -z $3 && -z $4 ]] && content=$2 prefix=''

  echo -n "%{%B%}" # set bold
  if [[ $spaceship_prompt_opened == true ]] && [[ $SPACESHIP_PROMPT_PREFIXES_SHOW == true ]]; then
    echo -n "$prefix"
  fi
  spaceship_prompt_opened=true
  echo -n "%{%b%}" # unset bold

  echo -n "%{%B$color%}" # set color
  echo -n "$content"     # section content
  echo -n "%{%b%f%}"     # unset color

  echo -n "%{%B%}" # reset bold, if it was diabled before
  if [[ $SPACESHIP_PROMPT_SUFFIXES_SHOW == true ]]; then
    echo -n "$suffix"
  fi
  echo -n "%{%b%}" # unset bold
}

# Check if the current directory is in a Git repository.
# USAGE:
#   spaceship::is_git
function spaceship_is_arc() {
  # See https://git.io/fp8Pa for related discussion
  echo "$(arc rev-parse --is-inside-work-tree 2>/dev/null)"
}

SPACESHIP_ARC_BRANCH_SHOW="${SPACESHIP_ARC_BRANCH_SHOW=true}"
SPACESHIP_ARC_BRANCH_PREFIX="${SPACESHIP_ARC_BRANCH_PREFIX="$SPACESHIP_ARC_SYMBOL"}"
SPACESHIP_ARC_BRANCH_SUFFIX="${SPACESHIP_ARC_BRANCH_SUFFIX=""}"
SPACESHIP_ARC_BRANCH_COLOR="${SPACESHIP_ARC_BRANCH_COLOR="magenta"}"

function spaceship_arc_branch() {
  local arc_current_branch="$(head -n 1 ~/.arc/__branch_name)"
  [[ -z "$arc_current_branch" ]] && return

  arc_current_branch="${arc_current_branch}"

  echo $arc_current_branch | sed "s/\//\\\\\//g"
}

#
# arc status
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_ARC_STATUS_SHOW="${SPACESHIP_ARC_STATUS_SHOW=true}"
SPACESHIP_ARC_STATUS_PREFIX="${SPACESHIP_ARC_STATUS_PREFIX=" ["}"
SPACESHIP_ARC_STATUS_SUFFIX="${SPACESHIP_ARC_STATUS_SUFFIX="]"}"
SPACESHIP_ARC_STATUS_COLOR="${SPACESHIP_ARC_STATUS_COLOR="red"}"
SPACESHIP_ARC_STATUS_UNTRACKED="${SPACESHIP_ARC_STATUS_UNTRACKED="?"}"
SPACESHIP_ARC_STATUS_ADDED="${SPACESHIP_ARC_STATUS_ADDED="+"}"
SPACESHIP_ARC_STATUS_MODIFIED="${SPACESHIP_ARC_STATUS_MODIFIED="!"}"
SPACESHIP_ARC_STATUS_RENAMED="${SPACESHIP_ARC_STATUS_RENAMED="»"}"
SPACESHIP_ARC_STATUS_DELETED="${SPACESHIP_ARC_STATUS_DELETED="✘"}"
SPACESHIP_ARC_STATUS_STASHED="${SPACESHIP_ARC_STATUS_STASHED="$"}"
SPACESHIP_ARC_STATUS_UNMERGED="${SPACESHIP_ARC_STATUS_UNMERGED="="}"
SPACESHIP_ARC_STATUS_AHEAD="${SPACESHIP_ARC_STATUS_AHEAD="⇡"}"
SPACESHIP_ARC_STATUS_BEHIND="${SPACESHIP_ARC_STATUS_BEHIND="⇣"}"
SPACESHIP_ARC_STATUS_DIVERGED="${SPACESHIP_ARC_STATUS_DIVERGED="⇕"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# We used to depend on OMZ arc library,
# But it doesn't handle many of the status indicator combinations.
# Also, It's hard to maintain external dependency.
# See PR #147 at https://arc.io/vQkkB
# See arc help status to know more about status formats
function spaceship_arc_status() {
  [[ $SPACESHIP_ARC_STATUS_SHOW == false ]] && return

  spaceship_is_arc || return

  local INDEX arc_status=""

  INDEX=$(command arc status -s -b 2>/dev/null)

  # Check for untracked files
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_UNTRACKED$arc_status"
  fi

  # Check for staged files
  if $(echo "$INDEX" | command grep '^A[ MDAU] ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_ADDED$arc_status"
  elif $(echo "$INDEX" | command grep '^M[ MD] ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_ADDED$arc_status"
  elif $(echo "$INDEX" | command grep '^UA' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_ADDED$arc_status"
  fi

  # Check for modified files
  if $(echo "$INDEX" | command grep '^[ MARC]M ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_MODIFIED$arc_status"
  fi

  # Check for renamed files
  if $(echo "$INDEX" | command grep '^R[ MD] ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_RENAMED$arc_status"
  fi

  # Check for deleted files
  if $(echo "$INDEX" | command grep '^[MARCDU ]D ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_DELETED$arc_status"
  elif $(echo "$INDEX" | command grep '^D[ UM] ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_DELETED$arc_status"
  fi

  # Check for stashes
  if $(command arc rev-parse --verify refs/stash >/dev/null 2>&1); then
    arc_status="$SPACESHIP_ARC_STATUS_STASHED$arc_status"
  fi

  # Check for unmerged files
  if $(echo "$INDEX" | command grep '^U[UDA] ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_UNMERGED$arc_status"
  elif $(echo "$INDEX" | command grep '^AA ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_UNMERGED$arc_status"
  elif $(echo "$INDEX" | command grep '^DD ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_UNMERGED$arc_status"
  elif $(echo "$INDEX" | command grep '^[DA]U ' &> /dev/null); then
    arc_status="$SPACESHIP_ARC_STATUS_UNMERGED$arc_status"
  fi

  # Check whether branch is ahead
  local is_ahead=false
  if $(echo "$INDEX" | command grep '^## [^ ]\+ .*ahead' &> /dev/null); then
    is_ahead=true
  fi

  # Check whether branch is behind
  local is_behind=false
  if $(echo "$INDEX" | command grep '^## [^ ]\+ .*behind' &> /dev/null); then
    is_behind=true
  fi

  # Check wheather branch has diverged
  if [[ "$is_ahead" == true && "$is_behind" == true ]]; then
    arc_status="$SPACESHIP_ARC_STATUS_DIVERGED$arc_status"
  else
    [[ "$is_ahead" == true ]] && arc_status="$SPACESHIP_ARC_STATUS_AHEAD$arc_status"
    [[ "$is_behind" == true ]] && arc_status="$SPACESHIP_ARC_STATUS_BEHIND$arc_status"
  fi

  if [[ -n $arc_status ]]; then
    # Status prefixes are colorized
    echo \
      "$SPACESHIP_ARC_STATUS_COLOR" \
      "$SPACESHIP_ARC_STATUS_PREFIX$arc_status$SPACESHIP_ARC_STATUS_SUFFIX"
  fi
}

function custom_prompt() {
    starship_prompt="$(starship prompt $@)"
    first_part="$(echo $starship_prompt | head -n 2)"
    # second_part="$(echo $starship_prompt | tail -n 1 | sed s/^/\[$__SPACESHIP_VIM_MODE\]\ /)"
    second_part="$(echo $starship_prompt | tail -n 1)"
    if [ "$(spaceship_is_arc)" = true ]; then
        updated_first_part=$(echo $first_part | perl -p -e "s/([^\\s]+)\\s(.+)/\$1 \\e\[1;35m $(spaceship_arc_branch)\\e\[0m \$2/g")
        echo -e "$updated_first_part\n$second_part"
        # echo -e "$first_part \e[1;35m $(spaceship_arc_branch)\e[0m\n$second_part"

        # Async update file with branch
        arc info | grep -o -Ee "branch: .*" | cut -d ' ' -f 2 > ~/.arc/__branch_name &
    else
        echo -e "$first_part\n$second_part"
    fi
}


# Set up the session key that will be used to store logs
STARSHIP_SESSION_KEY="$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM"; # Random generates a number b/w 0 - 32767
STARSHIP_SESSION_KEY="${STARSHIP_SESSION_KEY}0000000000000000" # Pad it to 16+ chars.
export STARSHIP_SESSION_KEY=${STARSHIP_SESSION_KEY:0:16}; # Trim to 16-digits if excess.

VIRTUAL_ENV_DISABLE_PROMPT=1

setopt promptsubst


PROMPT='$(custom_prompt --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
RPROMPT='$(custom_prompt --right --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
PROMPT2="$(custom_prompt --continuation)"

