tmux rename-window 'monitor'
tmux split-window -h -t monitor
tmux split-window -v -t monitor.1
tmux split-window -v -t monitor.3

tmux resize-pane -D -t monitor.2 15
tmux resize-pane -D -t monitor.3 15

tmux send-keys -t monitor.1 'watch -n 3 "ps -eo 'pid, %cpu, %mem, start, etime, command' | grep -E \"(vim|make|docker|python|ruby|rspec|test|rails|puma|spring|guard|bootsnap|mysql|redis|sidekiq|delayed_job|yarn|npm)\" | grep -v -e grep -e fsevent -e start_host -e .cache | sort -b -f -k 6r,6r -k1"' C-m
tmux send-keys -t monitor.2 'watch -n 3 "tmux list-sessions"' C-m
tmux send-keys -t monitor.3 'htop' C-m

tmux select-pane -t monitor.4
