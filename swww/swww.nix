# Animated wallpaper configuration using swww
# swww is a modern Wayland wallpaper daemon that supports:
# - Animated GIFs with efficient caching
# - Runtime wallpaper switching
# - Per-monitor wallpaper support
# - Low CPU usage after initial caching
{pkgs, ...}:

{
  home.packages = with pkgs; [
    swww  # Animated wallpaper daemon for Wayland
  ];

  # swww doesn't use config files - it's controlled via CLI commands
  # Configuration is handled through autostart commands in hyprland.nix
}