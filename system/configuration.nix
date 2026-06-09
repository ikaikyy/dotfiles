{
  config,
  lib,
  pkgs,
  hostName,
  ...
}:
{
  nix.settings = {
    trusted-users = [
      "root"
      "ikaikyy"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
    permittedInsecurePackages = [
      "qtwebengine-5.15.19"
      "ventoy-gtk3-1.1.10"
    ];
  };

  networking.hostName = "nixos-${hostName}";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.zsh.enable = true;

  users.users.ikaikyy = {
    isNormalUser = true;
    description = "Kaiky Eduardo Martins de Faria";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    vim
    usbutils
    udiskie
    udisks2
    pkgs.nur.repos.ataraxiasjel.waydroid-script
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire-pulse = lib.mkIf (hostName == "desktop") {
      "10-simultaneous-output" = {
        "pulse.cmd" = [
          {
            cmd = "load-module";
            args = "module-combine-sink sink_name=simultaneous_output sink_properties=device.description=Simultaneous_Output slaves=alsa_output.pci-0000_03_00.1.hdmi-stereo-extra2,alsa_output.pci-0000_00_1b.0.analog-stereo";
          }
        ];
      };
    };
  };

  services.upower.enable = true;
  services.flatpak.enable = true;

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  system.stateVersion = "24.11"; # Did you read the comment?
}
