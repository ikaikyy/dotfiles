{
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    qemu_kvm
    libvirt
    virt-manager
    virt-viewer
    docker
    docker-compose
    libguestfs-with-appliance
    bottles
  ];

  users.users.ikaikyy.extraGroups = [
    "docker"
    "kvm"
    "adbusers"
    "libvirtd"
  ];

  virtualisation = {
    docker.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    waydroid.enable = true;
    spiceUSBRedirection.enable = true;
  };
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
