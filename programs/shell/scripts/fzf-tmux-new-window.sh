set -e

target_dir=$(fd --type d . "$HOME" | fzf-tmux -x)
if [ -z "${target_dir:-}" ]; then
	echo "No directory selected, exiting." >&2
	exit 1
fi
dir_name=$(basename "$target_dir")

tmux new-window -n "$dir_name" -c "$target_dir"
