vssh (){
    if [[ $1 ]]; then
        ssh $1 -t "export VIMINIT='$MINIMAL_VIMINIT' &&  bash";
    else
        echo "Provide remote user@host";
    fi
}
