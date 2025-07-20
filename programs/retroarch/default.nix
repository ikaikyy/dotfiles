{ config, pkgs, ... }:
let
  retroarchWithCores = (pkgs.retroarch.withCores (cores:
    with cores; [
      vba-next # GBA emulator
      desmume # NDS emulator
      citra # 3DS emulator
      snes9x # SNES emulator
      dolphin # Wii emulator
    ]));
in { home.packages = [ retroarchWithCores pkgs.ryubing ]; }
