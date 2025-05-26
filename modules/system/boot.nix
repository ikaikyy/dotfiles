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

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;

        extraEntries = ''
          menuentry "Poweroff" {
            poweroff
          }

          menuentry "Reboot" {
            reboot
          }
        '';
      };

      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;

      extraConfig = ''
        [Daemon]
        DeviceScale=1
      '';

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
