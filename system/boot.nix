{ config, pkgs, ... }: {
  boot = {
    extraModprobeConfig = ''
      options iwlwifi bt_coex_active=0 swcrypto=1 11n_disable=8
      options iwlmvm power_scheme=1
    '';

    kernelPackages = pkgs.linuxPackages_latest;

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
        configurationLimit = 5;

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
