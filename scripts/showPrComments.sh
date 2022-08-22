OLDIFS="$IFS"
IFS=$'\n' # bash specific

inComment=false
nextName=false

TITLE="\e[1;38;5;33m"
GREEN_COLOR="\e[38;5;28m"
YELLOW_COLOR="\e[38;5;172m"
REVIEW="\e[38;5;36m"
END_COLOR="\e[0m"

for line in $(printf '%s\n' "$(moontool review-comments $(arc pr st -s | cut -d ' ' -f 1))")
do
    if [[ "$inComment" == "false" ]] && [[ ! -z $line ]]; then
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

        inComment=true
        path=$(echo $line | cut -d ':' -f 1)
        lineNumber=$(echo $line | cut -d ':' -f 2)

        arc_root_path=$(arc rev-parse --show-toplevel 2>/dev/null)
        
        if [ -z $arc_root_path ]; then
            exit 1
        fi

        ((preview_from=$lineNumber-5))
        ((preview_to=$lineNumber+5))

        bat -r $preview_from:$preview_to -H $lineNumber ./$path
        nextName=true
    elif [ "$nextName" == "true" ]; then 
        commentTitle=$(echo "$line" | sed -e 's/^> /\t/')

        name=$(echo $commentTitle | cut -d " " -f 1)
        status=$(echo $commentTitle | cut -d " " -f 2)

        # Show subcomments
        if [[ "$line" =~ "> " ]]; then 
            printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' - | sed -e 's/^--------/\t/'
        fi

        case $status in

          open)
            status="${YELLOW_COLOR}$status${END_COLOR}"
            ;;

          resolved)
            status="${GREEN_COLOR}$status${END_COLOR}"
            ;;

          *)
            ;;
        esac

        printf "${TITLE}$name${END_COLOR} $status\n"
        nextName=false
    elif [ "$line" == ">>>>" ]; then 
        inComment=false
    elif [ "$line" == "----" ]; then 
        nextName=true
    else
        echo $line | sed -e 's/^> /\t/'
    fi
done

IFS="$OLDIFS"
