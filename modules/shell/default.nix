{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/dotfiles --use-remote-sudo";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
  };
}
