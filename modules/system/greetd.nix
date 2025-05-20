{ config, pkgs, ... }: {
  boot.kernelParams = [ "quiet" "splash" ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'dbus-run-session Hyprland'";
        user = "kaiky";
      };
    };
  };
}
