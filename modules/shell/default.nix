{ config, pkgs, ... }: {
  home.packages = with pkgs; [ zsh-powerlevel10k ];

  programs.zsh = {
    enable = true;

    shellAliases = {
      # Desktop
      update-desktop =
        "sudo nixos-rebuild switch --flake ~/dotfiles#nixos-desktop --use-remote-sudo";
      upgrade-desktop =
        "sudo nix flake update --flake ~/dotfiles && update-desktop --upgrade";

      # Laptop
      update-laptop =
        "sudo nixos-rebuild switch --flake ~/dotfiles#nixos-laptop --use-remote-sudo";
      upgrade-laptop =
        "sudo nix flake update --flake ~/dotfiles && update-laptop --upgrade";
    };

    initContent = ''
      if [[ -r "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme" ]]; then
        source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
      fi

      if [[ -r "$HOME/.p10k.zsh" ]]; then
        source "$HOME/.p10k.zsh"
      fi
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
      ];
    };
  };
}
