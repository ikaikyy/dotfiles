{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    grimblast
    satty
    (writeShellScriptBin "printscreen"
      "grimblast --freeze save area - | satty --filename - --copy-command wl-copy --action-on-enter save-to-clipboard --save-after-copy --early-exit --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png")
  ];
}
