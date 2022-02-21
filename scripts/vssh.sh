vssh (){
    if [[ $@ ]]; then
        ssh `printf "%q\n" "$@"` -t "export VIMINIT='$MINIMAL_VIMINIT' &&  bash"
    else
        echo "Provide remote user@host";
    fi
}
