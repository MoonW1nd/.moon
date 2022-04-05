command=

if [ ! -z "$(arc info 2>/dev/null)" ]; then
    command=arc
elif [ ! -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
    command=git
else
    echo "[WARN] Not supported vcs"
    exit 1
fi

get_branch_name() {
    if [ "$command" = "arc" ]; then
        arc info | grep -o -Ee "branch: .*" | cut -d ' ' -f 2
    else
        git name
    fi
}

get_ticket_name() {
    if [ "$command" = "arc" ]; then
        get_branch_name | perl -lne 'print $1 if /([A-Z]*-[0-9]*)/'
    else
        git tname
    fi
}


if [ "$1" = "checkout" ] || [ $1 = "co" ]; then
    if [ "$2" != "-b" ] && [ "$command" = "git" ]; then
        $command checkout $($command branch -r | fzf)
    elif [ "$command" = "arc" ] && [ -z "$2" ]; then
        $command checkout $($command branch --list | fzf)
    else
        shift
        $command checkout $@
    fi
elif [ "$1" = "uc" ]; then
    $command reset --soft HEAD^
elif [ "$1" = "fpr" ]; then
    if [ "$command" = "arc" ]; then
        # TODO add support not setted
        $command pull -r $($command branch --list | fzf)
    else
        $command fpr
    fi
elif [ "$1" = "branch" ] && [ "$2" = "rename" ]; then
    if [ -z "$3" ]; then
        echo "[WARN] Need set new name to branch"
        exit 1
    fi

    if [ "$command" = "arc" ]; then
        $command branch -m $3
    else
        $command branch -m $(get_branch_name) $3
    fi
elif [ "$1" = "tc" ]; then
    if [ -z "$2" ]; then
        echo "[WARN] Need set commit message"
        exit 1
    fi

    shift
    $command commit -m \"$(get_ticket_name): $@\"
elif [ "$1" = "hist" ]; then
    if [ "$command" = "arc" ]; then
        # TODO add support for git show PR links and commits link
        if [ "$2" = "-l" ]; then
            $command log --format "{color.yellow}{commit.short}{color.reset} {title} {color.red}{date_utc}{color.reset} {color.blue}{author}{color.reset} {color.red}{branches}{color.reset}\nLink: {color.green}https://a.yandex-team.ru/arc/commit/r{revision}\nPR:   {color.green}https://a.yandex-team.ru/review/{attr.pr.id}/details"
        else
            $command log --format "{color.yellow}{commit.short}{color.reset} {title} {color.red}{date_utc}{color.reset} {color.blue}{author}{color.reset} {color.red}{branches}{color.reset}"
        fi
    else
        $command log --color --pretty=format:"%C(yellow)%h%C(reset) %s%C(bold red)%d%C(reset) %C(green)%ad%C(reset) %C(blue)[%an]%C(reset)" --relative-date --decorate
    fi
else
    $command $@
fi
