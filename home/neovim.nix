# home/neovim.nix
{ pkgs-unstable, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true; # Sets Neovim as the default editor via $EDITOR
    viAlias = true;       # Creates a 'vi' alias to 'nvim'
    vimAlias = true;      # Creates a 'vim' alias to 'nvim'

    # Plugin packages are separate from configuration
    plugins = with pkgs-unstable.vimPlugins; [
      # File explorer
      nvim-tree-lua

      # Status line
      lualine-nvim


      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      # Language Server Protocol (LSP) configuration
      nvim-lspconfig
    ];

    # extraLuaConfig vs extraConfig: Lua goes here, Vimscript in extraConfig
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

      -- Configure nvim-tree
      require("nvim-tree").setup()

      -- Configure lualine (theme will be set by Catppuccin module)
      require('lualine').setup {}

      -- Keybindings
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
    '';
  };

  # Enable Catppuccin theming for Neovim
  catppuccin.nvim.enable = true;
}