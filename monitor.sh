tmux rename-window 'monitor'
tmux split-window -h -t monitor
tmux split-window -v -t monitor.2
tmux split-window -v -t monitor.3

tmux send-keys -t monitor.1 'watch -n 3 "ps -eo 'pid, %cpu, %mem, start, etime, command' | grep -E \"(vim|nvim|ruby|rails|puma|pa_|my_|spring|mysql|redis|sidekiq|delayed_job)\" | grep -v -e grep -e fsevent -e start_host | sort -b -f -k 6r,6r -k1"' C-m
tmux send-keys -t monitor.2 'htop' C-m
tmux send-keys -t monitor.3 'watch -n 3 "tmux list-sessions"' C-m

tmux select-pane -t monitor.4
