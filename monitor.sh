tmux rename-window 'monitor'
tmux split-window -h -t monitor
tmux split-window -v -t monitor.2
tmux split-window -v -t monitor.3

tmux send-keys -t monitor.1 'watch -n 3 "pstree -U |grep -E \"(vim|nvim|ruby|rails|puma|pa_|my_|spring|mysql|redis|sidekiq|delayed_job|ssh)\" | grep -v -e grep -e fsevent"' C-m
tmux send-keys -t monitor.2 'htop' C-m
tmux send-keys -t monitor.3 'watch -n 3 "tmux list-sessions"' C-m

tmux select-pane -t monitor.4
