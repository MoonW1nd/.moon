# create layout for build frontend session
dev_server_session_name="[affiliate] dev server"

tmux new-session -d -s "$dev_server_session_name"
tmux rename-window -t 1 "[affiliate] frontend build"
tmux split-window -v -p 11

tmux selectp -t "$dev_server_session_name":1.0
tmux send-keys "z aff && make hmr-client" C-m

tmux selectp -t "$dev_server_session_name":1.1
tmux send-keys "z aflt-test && npm start" C-m

vim_session_name="vim"

tmux new-session -d -s "$vim_session_name"
tmux rename-window -t 1 "[affiliate]"
tmux new-window -t "$vim_session_name":2 -n "[aflt-test]"

tmux selectw -t "$vim_session_name":1
tmux send-keys "z aff && vim" C-m

tmux selectw -t "$vim_session_name":2
tmux send-keys "z aflt-tet && vim ./src/pages" C-m

tmux attach-session -t "$vim_session_name":1

