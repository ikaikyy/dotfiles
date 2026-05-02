{
  config,
  pkgs,
  ...
}:
{
  hardware.i2c.enable = true;

  users.users.ikaikyy.extraGroups = [
    "i2c"
    "video"
  ];

  boot.kernelModules = [ "i2c-dev" ];

  environment.systemPackages = with pkgs; [ ddcutil ];
}
