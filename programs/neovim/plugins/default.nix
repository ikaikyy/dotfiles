{...}: {
  imports = [
    ./ai-chat.nix
    ./completions.nix
    ./git.nix
    ./ui.nix
    ./navigation.nix
    ./treesitter.nix
  ];

  # Miscellaneous plugins
  programs.nixvim.plugins = {
    cord.enable = true;
  };
}
