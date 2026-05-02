{
  config,
  pkgs,
  ...
}: let
  fzf-tmux-sessions = pkgs.writeShellScript "fzf-tmux-sessions" (
    builtins.readFile ./scripts/fzf-tmux-sessions.sh
  );
  fzf-tmux-new-session = pkgs.writeShellScript "fzf-tmux-new-session" (
    builtins.readFile ./scripts/fzf-tmux-new-session.sh
  );
  fzf-tmux-new-window = pkgs.writeShellScript "fzf-tmux-new-window" (
    builtins.readFile ./scripts/fzf-tmux-new-window.sh
  );
in {
  home.packages = with pkgs; [
    ghostty
    zsh-powerlevel10k
    direnv
    fd
    fzf
  ];

  home.file.".config/ghostty/config".source = ./ghostty.config;

  programs.zsh = {
    enable = true;

    shellAliases = {
      # Desktop
      update-desktop = ''sudo nixos-rebuild switch --flake "$HOME/dotfiles?submodules=1#nixos-desktop" --sudo'';
      upgrade-desktop = ''sudo nix flake update --flake "$HOME/dotfiles" && update-desktop --upgrade'';

      # Laptop
      update-laptop = ''sudo nixos-rebuild switch --flake "$HOME/dotfiles?submodules=1#nixos-laptop" --sudo'';
      upgrade-laptop = ''sudo nix flake update --flake "$HOME/dotfiles" && update-laptop --upgrade'';

      tmux = "tmux -2";
    };

    initContent = ''
      if [[ -r "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme" ]]; then
        source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
      fi

      if [[ -r "$HOME/.p10k.zsh" ]]; then
        source "$HOME/.p10k.zsh"
      fi

      if [[ -z "$TMUX" ]]; then
        tmux attach-session -t main || tmux new-session -s main &&\
          tmux rename-window -t main:1 dotfiles &&\
          cd "$HOME/dotfiles"
      fi

      export FZF_DEFAULT_COMMAND="fd --type d"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "command-not-found"
        "docker"
        "git"
        "git-commit"
        "sudo"
        "tmux"
      ];
    };
  };

  programs.tmux = {
    enable = true;

    baseIndex = 1;
    clock24 = true;

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g status-left-length 40

      set-window-option -g mode-keys vi
      set -s escape-time 0

      unbind-key -a
      unbind-key -a -T root

      bind -n C-M-r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      set -g prefix M-Space

      bind s run-shell "${fzf-tmux-new-session}"
      bind n run-shell "${fzf-tmux-new-window}"
      bind r command-prompt -p "window name:" "rename-window '%%'"

      bind [ split-window -v -c "#{pane_current_path}"
      bind ] split-window -h -c "#{pane_current_path}"
      bind w killp

      bind -n M-, previous-window
      bind -n M-. next-window

      bind -n M-h if -F "#{pane_at_left}" "" "selectp -L"
      bind -n M-j if -F "#{pane_at_bottom}" "" "selectp -D"
      bind -n M-k if -F "#{pane_at_top}" "" "selectp -U"
      bind -n M-l if -F "#{pane_at_right}" "" "selectp -R"

      bind v copy-mode
      bind m run-shell "${fzf-tmux-sessions}"
    '';

    plugins = [
      {
        plugin = pkgs.tmuxPlugins.minimal-tmux-status;
        extraConfig = ''
          set -g @minimal-tmux-bg "#98971A"
          set -g @minimal-tmux-fg "#FBF1C7"
        '';
      }
    ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
