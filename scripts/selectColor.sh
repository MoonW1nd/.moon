for code in {0..255}
    do printf "\e[38;5;${code}m"'\\e[38;5;'"$code"m"\e[0m\n"
done | fzf | pbcopy
