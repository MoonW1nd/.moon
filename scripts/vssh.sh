#!/bin/bash

# Connect to host with ssh provide minimal vim config.

if [[ $@ ]]; then
    if [ "$1" = "-t" ]; then
        command=$2
        shift
        shift
        ssh $@ -t "export VIMINIT='$MINIMAL_VIMINIT' && bash -c '$command'"
    else
        ssh $@ -t "export VIMINIT='$MINIMAL_VIMINIT' && bash"
    fi

else
    echo "Provide remote user@host";
fi
