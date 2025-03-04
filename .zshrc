export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto

zstyle ':omz:update' frequency 7

COMPLETION_WAITING_DOTS="%F{yellow}loading...%f"

plugins=(archlinux colored-man-pages command-not-found docker git git-commit sudo)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias dotfiles="nvim ~/git/dotfiles"

export ANDROID_HOME=/home/kaiky/Android/Sdk

