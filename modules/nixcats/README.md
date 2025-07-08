# nixCats Neovim Configuration

This directory contains a high-performance Neovim configuration built with nixCats for faster startup times and better lazy loading support.

## Features

### Core Functionality
- **Fast Startup**: Optimized with lazy loading plugins using lze (nixCats lazy loader)
- **Category-based Loading**: nixCats categories for efficient plugin management
- **Modern UI**: Gruvbox theme with transparent background
- **Smart Completion**: nvim-cmp with LSP integration

### Language Support
- **TypeScript/JavaScript** (Primary): ts_ls, eslint, prettier
- **Python**: pylsp, black, isort formatting
- **PHP**: intelephense, blade-formatter
- **Rust**: rust-analyzer, rustfmt
- **Lua**: lua_ls, stylua
- **Nix**: nil LSP, nixfmt
- **Go**: gopls
- **C/C++**: clangd
- **HTML/CSS/JSON**: vscode-langservers-extracted
- **SQL**: Database tools via development packages

### Development Tools
- **LSP**: Full language server protocol support
- **Formatting**: conform.nvim for fast formatting
- **Linting**: nvim-lint for code quality
- **Git Integration**: gitsigns.nvim
- **File Navigation**: nvim-tree, telescope
- **Debugging**: Integrated debugging support
- **AI Assistance**: GitHub Copilot integration

### Performance Optimizations
- Lazy loading for all non-essential plugins using lze
- Category-based plugin organization
- Optimized treesitter configuration
- Disabled unnecessary vim plugins
- Fast telescope with smart file filtering

## Configuration Structure

```
modules/nixcats/
├── default.nix              # Main nixCats home-manager module
├── init.lua                 # Entry point
├── lua/config/              # Core configuration
│   ├── options.lua          # Vim options and settings
│   ├── keymaps.lua          # Key mappings
│   ├── autocmds.lua         # Auto commands
│   ├── colorscheme.lua      # Theme configuration
│   └── plugins.lua          # lze plugin manager setup
└── lua/plugins/             # Individual plugin configs
    ├── lsp.lua              # Language server configuration
    ├── treesitter.lua       # Syntax highlighting
    ├── telescope.lua        # Fuzzy finder
    ├── cmp.lua              # Completion engine
    ├── conform.lua          # Formatting
    ├── lint.lua             # Linting
    ├── lualine.lua          # Status line
    ├── nvim-tree.lua        # File explorer
    ├── trouble.lua          # Diagnostics
    ├── gitsigns.lua         # Git integration
    ├── copilot.lua          # AI assistance
    ├── alpha.lua            # Dashboard
    └── autopairs.lua        # Auto-pairing
```

## Key Bindings

### Leader Key: `<Space>`

#### File Operations
- `<leader>sv` - Save buffer
- `<leader>pv` - Toggle file explorer
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers

#### LSP & Development
- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<leader>fmt` - Format buffer
- `<leader>td` - Buffer diagnostics
- `<leader>tD` - Workspace diagnostics

#### Buffer Management
- `<S-h>` - Previous buffer
- `<S-l>` - Next buffer
- `<leader>bd` - Delete buffer

### Git
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line

## Categories

nixCats organizes functionality into language-specific categories for optimal loading:

- **general**: Core functionality loaded for all configurations
- **typescript**: TypeScript/JavaScript support and tools
- **python**: Python development environment
- **php**: PHP development environment  
- **rust**: Rust development environment
- **lua**: Lua scripting support
- **nix**: Nix language support
- **go**: Go development environment
- **web**: HTML/CSS/JSON/Markdown support
- **c**: C/C++ development environment
- **database**: Database tools and SQL support
- **format**: Formatting and linting tools

## Migration from nixvim

This configuration replaces the previous nixvim setup with several improvements:

1. **Performance**: Faster startup through lze lazy loading
2. **Modularity**: Better organized plugin structure following nixCats patterns
3. **Maintainability**: Cleaner configuration files with proper home-manager module
4. **Extensibility**: Easy to add new plugins and features
5. **Optimization**: Language-specific category-based loading reduces resource usage
6. **Compatibility**: Follows nixCats best practices and example templates

The configuration maintains all previous functionality while providing significant performance improvements for daily development work.