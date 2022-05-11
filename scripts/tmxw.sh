# create layout for build frontend session
dev_server_session_name="[affiliate] dev server"

tmux new-session -d -s "$dev_server_session_name"
tmux rename-window -t 1 "[affiliate] frontend build"
tmux split-window -v -p 11

tmux selectp -t "$dev_server_session_name":1.0
tmux send-keys "z arc aff && make hmr-client" C-m

tmux selectp -t "$dev_server_session_name":1.1
tmux send-keys "z aff-test && npm run dev" C-m

vim_session_name="vim"

# create windows
tmux new-session -d -s "$vim_session_name"
tmux rename-window -t 1 "[affiliate]"
tmux new-window -t "$vim_session_name":2 -n "[dotfiles]"
tmux new-window -t "$vim_session_name":3 -n "[agenda]"

# run commands in [affiliate]
tmux selectw -t "$vim_session_name":1
tmux send-keys "z arc aff && vim" C-m

# run commands in [dotfiles]
tmux selectw -t "$vim_session_name":2
tmux send-keys "z dotfiles && vim ./" C-m

# run commands in [agenda]
tmux selectw -t "$vim_session_name":3
tmux send-keys "moontool info" C-m

# go to work window
tmux attach-session -t "$vim_session_name":1

