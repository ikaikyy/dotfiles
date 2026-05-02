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
    nixvim.url = "github:nix-community/nixvim";
    # spicetify-nix = {
    #   url = "github:Gerg-L/spicetify-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    ...
  } @ inputs: {
    nixosConfigurations = let
      mkHost = hostName:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit hostName;};
          modules = [
            (./hosts + "/${hostName}/hardware-configuration.nix")
            ./system
            home-manager.nixosModules.home-manager
            nur.modules.nixos.default
            {
              nixpkgs.overlays = [(import ./overlays/kotlin-lsp.nix)];

              home-manager.backupFileExtension = "bak";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit inputs hostName;};
              home-manager.users.ikaikyy = ./home.nix;
            }
          ];
        };
    in {
      nixos-desktop = mkHost "desktop";
      nixos-laptop = mkHost "laptop";
    };
  };
}
