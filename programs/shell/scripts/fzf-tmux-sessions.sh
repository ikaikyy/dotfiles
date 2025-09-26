set -e

tmuxsessions=$(tmux list-sessions -F "#{session_name}")

target_session=$(sort -rfu <<<"$tmuxsessions" | fzf-tmux -x | tr -d '\n')

if [[ -n "$target_session" ]] && grep -qFx "$target_session" <<<"$tmuxsessions"; then
	tmux switch-client -t "$target_session"
fi
