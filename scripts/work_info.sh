#!/bin/bash

cd $HOME/Documents/develop/work/arcadia/

TITLE="\e[1;38;5;33m"
REVIEW="\e[38;5;36m"
END_COLOR="\e[0m"

while true
do
    clear
    printf "${TITLE}Tracker${END_COLOR}\n"
    echo -e ""

    moontool info
    
    printf "${TITLE}\nArc\n${END_COLOR}"
    echo -e ""
    printf "${REVIEW}Нужно провести ревью${END_COLOR}\n"

    moontool review -s &
    # TODO spiner realization
    # pid=$! # Process Id of the previous running command
    #
    # spin[0]="-"
    # spin[1]="\\"
    # spin[2]="|"
    # spin[3]="/"
    #
    # echo -n "Get data: ${spin[0]}"
    #
    # while [ -z "$(kill -0 $pid 2>/dev/null || echo "confirm")" ]
    #
    # do
    #   for i in "${spin[@]}"
    #   do
    #         echo -ne "\b$i"
    #         sleep 0.1
    #   done
    # done
    sleep 600
done
