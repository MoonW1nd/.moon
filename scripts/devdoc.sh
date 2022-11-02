#!/usr/bin/env sh
# https://github.com/freeCodeCamp/devdocs/issues/133
# Select docs from devdocs.io using a fuzzy-finder for display at the CLI
#
# Deps: tidy, xmlstarlet, jq, lynx, fzy, curl, POSIX
# (This uses a few shell scripts from $HOME/bin. Look there for reference.)
#
# Download docsets:
#
#     devdocs-local choose
#     devdocs-local choose lodash~4 rxjs
#     devdocs-local choose_from /path/to/devdocs-prefs-export.json
#
# Query downloaded docsets:
#
#     devdocs-local

NAME=$(basename "$0")
TEMP="$TMPDIR-/tmp/${NAME}.${$}.$(awk \
'BEGIN {srand(); printf "%d\n", rand() * 10^10}')"

DEVDOCS_DIR="${DEVDOCS_DIR-"${HOME}/tmp/docs/devdocs.io"}"
mkdir -p "$DEVDOCS_DIR"

list () {
 # Find the docs JavaScript and try to extract the slug and mtime values.

 curl -sSL https://devdocs.io/docs.json | jq -r '.[] | [.slug, .mtime] | @tsv'
}

download () {
 # Download the docsets to a deterministic location.
 while read -r slug mtime; do
   test -n "$slug" || return

   ddir="${DEVDOCS_DIR}/${slug}"

   mkdir -p "$ddir"
   cd "$ddir"

   printf 'Installing %s\n' "$slug" 1>&2

   if [ -r "${ddir}/mtime" ]; then
     old_mtime=$(< "${ddir}/mtime")

     if [ "$old_mtime" -ge "$mtime" ]; then
       printf '%s already installed.\n' "$slug" 1>&2
       return
     fi
   fi

   printf '%s\n' "$mtime" > mtime

   curl -sS -o index.json "https://devdocs.io/docs/${slug}/index.json?${mtime}"
   curl -sS -o db.json "https://documents.devdocs.io/${slug}/db.json?${mtime}"
 done;
}

choose () {
 if [ $# -eq 0 ]; then
   list | fzf --prompt 'Choose a docset > ' | download
 else
   list | awk '
   BEGIN {
     for (i = 1; i < length(ARGV); i += 1) {
       docs[ARGV[i]] = 1; ARGV[i] = ""
     }
   }

   docs[$1] { print $0 }
   ' "$@" | download
 fi;
}

choose_from () {
 jq -r '.docs | split("/")[]' "${1:?Missing Devdocs Prefs export JSON}" |
 xargs "$0" choose
}

doc () {
 # need fix docs
 find "$DEVDOCS_DIR" -mindepth 1 -type d | rev | cut -d / -f 1 | rev |
 fzf --prompt 'Choose docs > ' | {
   read -r slug
   test -n "$slug" || return

   jq -r '.entries[] | "\(.name) --- \(.path) --- (\(.type))"' \
   "${DEVDOCS_DIR}/${slug}/index.json" |
   fzf --prompt 'Choose a topic > ' |
   awk -F " --- " '{
     h = index($2, "#")
     if (h == 0) {
       print $2
     } else {
       print substr($2, 1, h - 1), substr($2, h)
     }
   }' | {
   read -r dpath frag
   test -n "$dpath" || return

   jq -r ".\"${dpath}\"" \
   < "${DEVDOCS_DIR}/${slug}/db.json" \
   > "${TEMP}/index.html"

   lynx -vikeys -assume_charset=utf-8 \
   "file://localhost/${TEMP}/index.html${frag}"
   };
 }
}

main () {
 trap '
 excode=$?; trap - EXIT;
 rm -rf '"$TEMP"'
 exit $excode
 ' INT TERM EXIT
 mkdir -p -m 700 "$TEMP"

 if [ $# -eq 0 ]; then
   doc
 else
   cmd=$1
   shift

   "$cmd" "$@"
 fi
}

main "$@"

