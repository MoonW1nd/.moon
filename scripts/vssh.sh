sshh (){
    if [[ $1 ]]; then
        ssh -o SendEnv=LC_VIMINIT $1 -t 'export VIMINIT=$MINIMAL_VIMINIT && bash';
    else
        echo "Provide remote user@host";
    fi
}
