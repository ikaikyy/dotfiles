set -e

target_dir=$(fd --type d . "$HOME" | fzf-tmux -x)
if [ -z "${target_dir:-}" ]; then
	echo "No directory selected, exiting." >&2
	exit 1
fi

dir_name=$(basename "$target_dir")

# create session detached so the script can continue
tmux new-session -d -s "$dir_name" -c "$target_dir"

# create opencode window and run it there
tmux new-window -t "$dir_name" -n "opencode" -c "$target_dir"
tmux send-keys -t "${dir_name}:2" 'opencode' C-m

# create a "shell" window with splits
tmux new-window -t "$dir_name" -n "shell" -c "$target_dir"
tmux split-window -t "${dir_name}:3" -h -c "$target_dir"
tmux split-window -t "${dir_name}:3.1" -v -c "$target_dir"
tmux split-window -t "${dir_name}:3.3" -v -c "$target_dir"

# rename the first window and start nvim there, then attach
tmux rename-window -t "${dir_name}:1" "neovim"
tmux send-keys -t "${dir_name}:1" 'nvim' C-m
tmux switch-client -t "$dir_name"
