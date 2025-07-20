{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    grimblast
    swappy
    pngquant
    (writeShellScriptBin "printscreen" ''
      grimblast --freeze save area - | swappy -f - -o - | pngquant - | wl-copy --type image/png

      mkdir -p $HOME/Pictures/Screenshots

      img_path=$HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png

      wl-paste --type image/png > $img_path
    '')
  ];
}
