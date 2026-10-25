# Animated wallpaper configuration using awww (formerly swww)
# awww is a modern Wayland wallpaper daemon that supports:
# - Animated GIFs with efficient caching
# - Runtime wallpaper switching
# - Per-monitor wallpaper support
# - Low CPU usage after initial caching
{pkgs, ...}:

{
  home.packages = with pkgs; [
    awww  # Animated wallpaper daemon for Wayland
  ];

  # awww doesn't use config files - it's controlled via CLI commands
  # Configuration is handled through autostart commands in hyprland.nix
}