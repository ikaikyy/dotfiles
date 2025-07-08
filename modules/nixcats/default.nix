{ config, lib, inputs, ... }: let
  utils = inputs.nixCats.utils;
in {
  imports = [
    inputs.nixCats.homeModule
  ];
  config = {
    # this value, nixCats is the defaultPackageName you pass to mkHomeModules
    # it will be the namespace for your options.
    nixCats = {
      enable = true;
      # nixpkgs_version = inputs.nixpkgs;
      # this will add the overlays from ./overlays and also,
      # add any plugins in inputs named "plugins-pluginName" to pkgs.neovimPlugins
      # It will not apply to overall system, just nixCats.
      addOverlays = [
        (utils.standardPluginOverlay inputs)
      ];
      # see the packageDefinitions below.
      # This says which of those to install.
      packageNames = [ "myNixCats" ];

      luaPath = ./.;

      # the .replace vs .merge options are for modules based on existing configurations,
      # they refer to how multiple categoryDefinitions get merged together by the module.
      # for useage of this section, refer to :h nixCats.flake.outputs.categories
      categoryDefinitions.replace = ({ pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
        # to define and use a new category, simply add a new list to a set here,
        # and later, you will include categoryname = true; in the set you
        # provide when you build the package using this builder function.
        # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

        # lspsAndRuntimeDeps:
        # this section is for dependencies that should be available
        # at RUN TIME for plugins. Will be available to PATH within neovim terminal
        # this includes LSPs
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            ripgrep
            fd
            git
            curl
            tree-sitter
          ];
          typescript = with pkgs; [
            typescript-language-server
            nodePackages.eslint
            prettierd
            nodejs
          ];
          python = with pkgs; [
            python311Packages.python-lsp-server
            python311Packages.black
            python311Packages.isort
            python3
          ];
          php = with pkgs; [
            nodePackages.intelephense
            nodePackages.blade-formatter
          ];
          rust = with pkgs; [
            rust-analyzer
            rustfmt
            cargo
            rustc
          ];
          lua = with pkgs; [
            lua-language-server
            stylua
          ];
          nix = with pkgs; [
            nil
            nixfmt-rfc-style
          ];
          go = with pkgs; [
            gopls
            go
          ];
          web = with pkgs; [
            vscode-langservers-extracted # html, css, json
            htmx-lsp
            markdown-oxide
          ];
          c = with pkgs; [
            clang-tools
            gcc
          ];
          database = with pkgs; [
            mysql80
          ];
          format = with pkgs; [
            shfmt
          ];
        };

        # This is for plugins that will load at startup without using packadd:
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            # lazy loading isnt required with a config this small
            # but as a demo, we do it anyway.
            lze
            lzextras
            gruvbox-nvim
            vim-sleuth
          ];
        };

        # not loaded automatically at startup.
        # use with packadd and an autocommand in config to achieve lazy loading
        optionalPlugins = {
          general = with pkgs.vimPlugins; [
            # Core functionality
            nvim-web-devicons
            
            # LSP and completion
            nvim-lspconfig
            nvim-cmp
            cmp-nvim-lsp
            cmp-buffer
            cmp-path
            luasnip
            cmp_luasnip
            friendly-snippets
            
            # Navigation
            nvim-tree-lua
            telescope-nvim
            plenary-nvim
            
            # Treesitter
            nvim-treesitter.withAllGrammars
            nvim-treesitter-textobjects
            
            # Formatting and linting
            conform-nvim
            nvim-lint
            
            # UI
            lualine-nvim
            bufferline-nvim
            alpha-nvim
            trouble-nvim
            which-key-nvim
            
            # Git
            gitsigns-nvim
            
            # Editing
            comment-nvim
            nvim-autopairs
            nvim-surround
            
            # Copilot
            copilot-lua
            
            # Markdown
            markdown-preview-nvim
          ];
        };

        # shared libraries to be added to LD_LIBRARY_PATH
        # variable available to nvim runtime
        sharedLibraries = {
          general = with pkgs; [ ];
        };

        # environmentVariables:
        # this section is for environmentVariables that should be available
        # at RUN TIME for plugins. Will be available to path within neovim terminal
        environmentVariables = {
          # test = {
          #   CATTESTVAR = "It worked!";
          # };
        };

        # categories of the function you would have passed to withPackages
        python3.libraries = {
          # test = [ (_:[]) ];
        };

        # If you know what these are, you can provide custom ones by category here.
        # If you dont, check this link out:
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
        extraWrapperArgs = {
          # test = [
          #   '' --set CATTESTVAR2 "It worked again!"''
          # ];
        };
      });

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions.replace = {
        # These are the names of your packages
        # you can include as many as you wish.
        myNixCats = {pkgs, name, ... }: {
          # they contain a settings set defined above
          # see :help nixCats.flake.outputs.settings
          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = true;
            # unwrappedCfgPath = "/path/to/here";
            # IMPORTANT:
            # your alias may not conflict with your other packages.
            aliases = [ "vim" "vi" "nvim" ];
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
          };
          # and a set of categories that you want
          # (and other information to pass to lua)
          categories = {
            general = true;
            typescript = true;
            python = true;
            php = true;
            rust = true;
            lua = true;
            nix = true;
            go = false; # disabled by default, enable if needed
            web = true;
            c = false; # disabled by default, enable if needed
            database = true;
            format = true;
          };
          # anything else to pass and grab in lua with `nixCats.extra`
          extra = {
            # any extra variables you want in nixCats
          };
        };
      };
    };
    
    # Set EDITOR environment variable
    home.sessionVariables.EDITOR = "nvim";
  };
}