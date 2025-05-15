{ config, pkgs, ... }: {
  home.packages = with pkgs; [ nautilus ];

  xdg.mimeApps = {
    defaultApplications = {
      "inode/directory" = "nautilus";
      "application/x-iso9660-image" = "nautilus";
      "application/x-rar-compressed" = "nautilus";
      "application/x-tar" = "nautilus";
      "application/zip" = "nautilus";
      "application/x-xz-compressed-tar" = "nautilus";
      "application/x-bzip-compressed-tar" = "nautilus";
      "application/x-gzip-compressed-tar" = "nautilus";
    };
  };
}
