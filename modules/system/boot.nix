{ config, pkgs, ... }: {
  boot = {
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    consoleLogLevel = 3;
    initrd.verbose = false;

    loader.timeout = 0;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth = {
      enable = true;
      theme = "circuit";
      themePackages = with pkgs;
        [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "circuit" ];
          })
        ];
    };
  };
}
