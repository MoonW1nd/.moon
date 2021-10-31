# lf- List folders and cd to selected directory

lf() {
 local dir
 dir=$(ls -a ${1:-.} 2> /dev/null | fzf +m) &&
 cd "$dir"
}
