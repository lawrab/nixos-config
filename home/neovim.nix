# home/neovim.nix
{ pkgs-unstable, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true; # Sets Neovim as the default editor via $EDITOR
    viAlias = true;       # Creates a 'vi' alias to 'nvim'
    vimAlias = true;      # Creates a 'vim' alias to 'nvim'

    # Add a selection of popular and useful plugins
    plugins = with pkgs-unstable.vimPlugins; [
      # File explorer
      nvim-tree-lua

      # Status line
      lualine-nvim

      # Color scheme
      catppuccin-nvim

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      # Language Server Protocol (LSP) configuration
      nvim-lspconfig
    ];

    # Corrected: Use extraLuaConfig for Lua code
    extraLuaConfig = ''
      -- Set leader key to space
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      -- Sensible defaults
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = 'a'
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = false
      vim.opt.wrap = false

      -- Set colorscheme
      vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
      vim.cmd.colorscheme "catppuccin"

      -- Configure nvim-tree
      require("nvim-tree").setup()

      -- Configure lualine
      require('lualine').setup {
        options = {
          theme = 'catppuccin'
        }
      }

      -- Keybindings
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
    '';
  };
}