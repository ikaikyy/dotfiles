{
  config,
  lib,
  inputs,
  ...
}: let
  utils = inputs.nixCats.utils;
in {
  imports = [
    inputs.nixCats.homeModule
  ];
  config = {
    nixCats = {
      enable = true;
      addOverlays = [
        (utils.standardPluginOverlay inputs)
      ];
      packageNames = ["myNixCats"];

      luaPath = ./.;

      categoryDefinitions.replace = {
        pkgs,
        settings,
        categories,
        extra,
        name,
        mkPlugin,
        ...
      } @ packageDef: {
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
            intelephense
            pretty-php
            blade-formatter
          ];
          rust = with pkgs; [
            rust-analyzer
            dioxus-cli
            cargo
            rustc
          ];
          lua = with pkgs; [
            lua-language-server
            stylua
          ];
          nix = with pkgs; [
            nil
            alejandra
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
          shell = with pkgs; [
            shfmt
          ];
        };

        startupPlugins = {
          general = with pkgs.vimPlugins; [
            lze
            lzextras
            gruvbox-nvim

            # Core functionality
            nvim-web-devicons

            # LSP and completion
            nvim-lspconfig
            nvim-cmp
            cmp-nvim-lsp
            copilot-cmp
            cmp-buffer
            cmp-cmdline
            cmp-path
            none-ls-nvim
            lspkind-nvim

            # Navigation
            nvim-tree-lua
            telescope-nvim
            plenary-nvim

            # Treesitter
            nvim-treesitter.withAllGrammars

            # UI
            lualine-nvim
            copilot-lualine
            alpha-nvim
            trouble-nvim

            # Git
            gitsigns-nvim

            # Editing
            comment-nvim
            nvim-autopairs

            # Copilot
            copilot-lua

            # Markdown
            markdown-preview-nvim
          ];
        };

        optionalPlugins = {
          general = with pkgs.vimPlugins; [];
        };

        sharedLibraries = {
          general = with pkgs; [];
        };

        environmentVariables = {
        };

        python3.libraries = {
        };

        extraWrapperArgs = {
        };
      };

      packageDefinitions.replace = {
        myNixCats = {
          pkgs,
          name,
          ...
        }: {
          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = true;
            aliases = [
              "nvim"
            ];
          };
          categories = {
            general = true;
            typescript = true;
            python = true;
            php = true;
            rust = true;
            lua = true;
            nix = true;
            go = true;
            web = true;
            c = true;
            database = true;
            shell = true;
          };
          extra = {
          };
        };
      };
    };

    # Set EDITOR environment variable
    home.sessionVariables.EDITOR = "nvim";
  };
}
