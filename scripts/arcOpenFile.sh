#! /usr/bin/env bash

absolute_file_path=

if [ -z "$1" ]; then
    absolute_file_path=$PWD
else
    has_arc_url=$(echo $1 | grep -e 'arcadia/.\+' -o)

    if [ -z "$has_arc_url" ]; then
        absolute_file_path=$PWD/$1
    else
        absolute_file_path=$1
    fi
fi

arc_path=$(echo $absolute_file_path | grep -e 'arcadia/.\+' -o | cut -c 9-)

if [ -z "$arc_path" ]; then
    echo "Not detect arcadia root."
    exit 1
fi

open $ARCADIA_URL$arc_path

