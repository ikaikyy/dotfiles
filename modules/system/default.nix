{ config, pkgs, ... }: {
  imports = [
    ./configuration.nix
    ./greetd.nix
    ./gnupg.nix
    ./steam.nix
    ./boot.nix
    ./bluetooth.nix
  ];
}
