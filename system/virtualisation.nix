{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    qemu_kvm
    libvirt
    virt-manager
    virt-viewer
    docker
    docker-compose
    libguestfs-with-appliance
  ];

  users.users.kaiky.extraGroups = [
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
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
  };
  networking.firewall.trustedInterfaces = ["virbr0"];
}
