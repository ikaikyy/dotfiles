{ config, pkgs, ... }: {
  imports = [ ./configuration.nix ./greetd.nix ./gnupg.nix ./steam.nix ];
}
