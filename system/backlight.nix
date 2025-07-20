{ config, pkgs, ... }: {
  hardware.i2c.enable = true;
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="i2c-dev", ATTR{name}=="AMDGPU DM*", TAG+="ddcci", TAG+="systemd", ENV{SYSTEMD_WANTS}+="ddcci@$kernel.service"
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="ddcci*", RUN+="${pkgs.coreutils-full}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="ddcci*", RUN+="${pkgs.coreutils-full}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  systemd.services."ddcci@" = {
    scriptArgs = "%i";
    script = ''
      echo Trying to attach ddcci to $1
      id=$(echo $1 | cut -d "-" -f 2)
      counter=5
      while [ $counter -gt 0 ]; do
        if ${pkgs.ddcutil}/bin/ddcutil getvcp 10 -b $id; then
          echo ddcci 0x37 > /sys/bus/i2c/devices/$1/new_device
          echo Successfully attached ddcci to $1
          break
        fi
        sleep 1
        counter=$((counter - 1))
      done
    '';
    serviceConfig.Type = "oneshot";
  };

  users.users.kaiky.extraGroups = [ "i2c" "video" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ ddcci-driver ];
  boot.kernelModules = [ "i2c-dev" "ddcci-driver" "ddcci_backlight" ];

  environment.systemPackages = with pkgs; [ ddcutil brightnessctl ];
}
