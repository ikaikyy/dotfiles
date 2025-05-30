{ config, pkgs, ... }: {
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
