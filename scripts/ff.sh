# ff - Find any folder and cd to selected directory

ff() {
 local dir
 dir=$(fd ${1:-.} 2> /dev/null | fzf +m) &&
 cd "$dir"
}
