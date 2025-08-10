# home.nix
{ pkgs, pkgs-unstable, ... }:

{
  # Set the default shell for the user at the system level
  users.users.lrabbets.shell = pkgs.zsh;

  # Home Manager configuration for user environment
  home-manager.users.lrabbets = {
    imports = [
      # Window manager and desktop environment
      ./home/hyprland.nix      # Hyprland WM configuration
      ./home/waybar.nix        # Status bar
      ./home/wofi.nix          # Application launcher
      ./home/wlogout.nix       # Logout menu
      ./swww/swww.nix          # Animated wallpaper manager
      ./hyprlock/hyprlock.nix   # Screen locker
      
      # Applications and tools
      ./home/packages.nix      # System packages
      ./home/firefox.nix       # Web browser
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

    home.stateVersion = "25.05";
  };
}