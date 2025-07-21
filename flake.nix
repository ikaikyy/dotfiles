{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = {
    nixpkgs,
    home-manager,
    spicetify-nix,
    nur,
    ...
  } @ inputs: {
    nixosConfigurations = let
      mkHost = hostName:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (./hosts + "/${hostName}/hardware-configuration.nix")
            ./system
            ./modules/qbittorrent.nix
            home-manager.nixosModules.home-manager
            nur.modules.nixos.default
            {
              home-manager.backupFileExtension = "bak";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit inputs hostName;};
              home-manager.users.kaiky = ./home.nix;
            }
          ];
        };
    in {
      nixos-desktop = mkHost "desktop";
      nixos-laptop = mkHost "laptop";
    };
  };
}
