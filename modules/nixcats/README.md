# nixCats Neovim Configuration

This directory contains a high-performance Neovim configuration built with nixCats for faster startup times and better lazy loading support.

## Features

### Core Functionality
- **Fast Startup**: Optimized with lazy loading plugins using lazy.nvim
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
- Lazy loading for all non-essential plugins
- Category-based plugin organization
- Optimized treesitter configuration
- Disabled unnecessary vim plugins
- Fast telescope with smart file filtering

## Configuration Structure

```
modules/nixcats/
├── default.nix              # Main nixCats build configuration
├── init.lua                 # Entry point
├── lua/config/              # Core configuration
│   ├── options.lua          # Vim options and settings
│   ├── keymaps.lua          # Key mappings
│   ├── autocmds.lua         # Auto commands
│   ├── colorscheme.lua      # Theme configuration
│   └── plugins.lua          # Plugin manager setup
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

nixCats organizes functionality into categories for optimal loading:

- **startupPlugins**: Core functionality loaded immediately
- **lspsAndRuntimeDeps**: Language servers and development tools
- **navigation**: File explorer and search tools
- **completion**: Completion engine and snippets
- **ui**: Status line, dashboard, and visual plugins
- **git**: Git integration tools
- **format**: Formatting and linting tools
- **debug**: Debugging tools (future expansion)

## Testing

Run the test script to verify configuration integrity:

```bash
./test.sh
```

## Migration from nixvim

This configuration replaces the previous nixvim setup with several improvements:

1. **Performance**: Faster startup through lazy loading
2. **Modularity**: Better organized plugin structure
3. **Maintainability**: Cleaner configuration files
4. **Extensibility**: Easy to add new plugins and features
5. **Optimization**: Category-based loading reduces resource usage

The configuration maintains all previous functionality while providing significant performance improvements for daily development work.