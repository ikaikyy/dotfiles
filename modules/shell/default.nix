{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/dotfiles --use-remote-sudo";
      upgrade = "sudo nix flake update --flake ~/dotfiles && update --upgrade";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
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
