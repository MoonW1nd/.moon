# create layout for build frontend session
dev_server_session_name="terminal"

tmux new-session -d -s "$dev_server_session_name"
tmux rename-window -t 1 "[build]"
tmux split-window -v -p 11

tmux selectp -t "$dev_server_session_name":1.0
tmux send-keys "z arcadia" C-m

vim_session_name="vim"

# create windows
tmux new-session -d -s "$vim_session_name"
tmux rename-window -t 1 "[code]"
tmux new-window -t "$vim_session_name":2 -n "[dotfiles]"
tmux new-window -t "$vim_session_name":3 -n "[org]"

# run commands in [arcadia]
tmux selectw -t "$vim_session_name":1
tmux send-keys "z arcadia" C-m

# run commands in [dotfiles]
tmux selectw -t "$vim_session_name":2
tmux send-keys "z dotfiles && vim ./" C-m

# run commands in [org]
tmux selectw -t "$vim_session_name":3
tmux send-keys "z org && vim ./" C-m

# go to work window
tmux attach-session -t "$vim_session_name":1

