set -e

repo="${DOTFILES_REPO:-$HOME/dotfiles}"

if [ "$#" -eq 0 ]; then
  printf 'Usage: dotfiles-commit "type(scope): message"\n' >&2
  exit 1
fi

if ! git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf 'Dotfiles repo not found at %s\n' "$repo" >&2
  exit 1
fi

if [ -z "$(git -C "$repo" status --short)" ]; then
  printf 'Dotfiles repo is already clean.\n' >&2
  exit 0
fi

git -C "$repo" status --short
git -C "$repo" add -A
git -C "$repo" commit -m "$*"
