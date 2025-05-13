{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "kaikyeduardomf@gmail.com";
    userName = "Kaiky Eduardo Martins de Faria";
  };
}
