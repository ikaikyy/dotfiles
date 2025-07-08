{ inputs, pkgs, ... }:
let
  inherit (inputs.nixCats) utils;
  
  # Define the lua configuration path
  luaPath = "${./.}";
  
  # Extra package config
  extra_pkg_config = {
    allowUnfree = true;
  };
  
  # Dependency overlays
  dependencyOverlays = [
    (utils.standardPluginOverlay inputs)
  ];

  # Category definitions for lazy loading
  categoryDefinitions = {
    # Always loaded packages
    generalBuildInputs = {
      general = with pkgs; [
        ripgrep
        fd
        git
        curl
        tree-sitter
      ];
    };
    
    # LSP servers and language tools
    lspsAndRuntimeDeps = {
      general = with pkgs; [
        # TypeScript/JavaScript
        typescript-language-server
        nodePackages.eslint
        
        # Python
        python311Packages.python-lsp-server
        python311Packages.black
        python311Packages.isort
        
        # PHP
        nodePackages.intelephense
        nodePackages.blade-formatter
        
        # Rust
        rust-analyzer
        rustfmt
        
        # Other languages
        lua-language-server
        stylua
        nil # Nix LSP
        nixfmt-rfc-style
        gopls
        clang-tools
        htmx-lsp
        markdown-oxide
        
        # Web technologies
        vscode-langservers-extracted # html, css, json
        
        # Formatters
        prettierd
        shfmt
      ];
    };
    
    # Development tools
    devTools = {
      general = with pkgs; [
        nodejs
        python3
        cargo
        rustc
        go
        gcc
        mysql80
      ];
    };
    
    # Core editor functionality (always enabled)
    startupPlugins = {
      general = true;
    };
    
    # Lazy-loaded categories
    navigation = {
      general = true;
    };
    
    completion = {
      general = true;
    };
    
    ui = {
      general = true;
    };
    
    git = {
      general = true;
    };
    
    format = {
      general = true;
    };
    
    debug = {
      general = true;
    };
  };

  # Package definitions
  packageDefinitions = {
    nixCats = { pkgs, ... }: {
      settings = {
        wrapRc = true;
        configDirName = "nixcats-nvim";
        aliases = [ "vim" "vi" ];
        neovim-unwrapped = inputs.nixpkgs.legacyPackages.${pkgs.system}.neovim-unwrapped;
      };
      categories = {
        inherit (categoryDefinitions) 
          generalBuildInputs
          lspsAndRuntimeDeps 
          devTools
          startupPlugins
          navigation
          completion
          ui
          git
          format
          debug;
      };
    };
  };

  # Build the nixCats configuration
  nixCatsBuilder = utils.baseBuilder luaPath {
    nixpkgs = inputs.nixpkgs;
    inherit dependencyOverlays extra_pkg_config;
  } categoryDefinitions packageDefinitions;

  # Create the final package
  nixCatsPackage = nixCatsBuilder.nixCats;
in
{
  # Install the nixCats neovim package
  home.packages = [ nixCatsPackage ];
  
  # Set EDITOR environment variable
  home.sessionVariables.EDITOR = "nvim";
}