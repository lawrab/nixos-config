# home.nix
{ pkgs, pkgs-unstable, catppuccin, ... }:

{
  # Set the default shell for the user at the system level
  users.users.lrabbets.shell = pkgs.zsh;

  # Home Manager configuration for user environment
  home-manager.users.lrabbets = {
    imports = [
      # Catppuccin theming system
      catppuccin.homeModules.catppuccin
      
      # Window manager and desktop environment
      ./home/hyprland.nix      # Hyprland WM configuration
      ./home/waybar.nix        # Status bar
      ./home/wofi.nix          # Application launcher
      ./home/wlogout.nix       # Logout menu
      ./swww/swww.nix          # Animated wallpaper manager
      ./hyprlock/hyprlock.nix   # Screen locker
      
      # Applications and tools
      ./home/packages.nix      # System packages
      ./home/cli-tools.nix     # CLI tools with Catppuccin theming
      ./home/browsers.nix      # Web browsers (Firefox & Brave)
      ./home/vscode.nix        # Code editor
      ./home/neovim.nix        # Terminal editor
      ./home/kitty.nix         # Terminal emulator
      ./home/1password.nix     # Password manager
      
      # Shell and development environment
      ./home/shell.nix         # Zsh configuration
      ./home/git.nix           # Git settings
      ./home/scripts.nix       # Custom scripts
      
      # System integration
      ./home/environment.nix   # Environment variables and secrets
      ./home/default-apps.nix  # Default applications
      ./home/service.nix       # User services
      ./home/gtk.nix           # GTK theming
    ];

    # Global Catppuccin configuration
    catppuccin = {
      enable = true;
      flavor = "mocha"; # Dark theme - options: latte, frappe, macchiato, mocha
    };

    home.stateVersion = "25.05";
  };
}