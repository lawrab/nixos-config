# Animated wallpaper configuration using awww (formerly swww)
# awww is a modern Wayland wallpaper daemon that supports:
# - Animated GIFs with efficient caching
# - Runtime wallpaper switching
# - Per-monitor wallpaper support
# - Low CPU usage after initial caching
{ ... }:

{
  # Runs awww-daemon as a systemd user service tied to the Wayland session,
  # restarted automatically if it crashes. Installs the awww CLI too.
  services.awww.enable = true;

  # awww doesn't use config files - wallpapers are set via `awww img`
  # (see wallpaper-rotate in scripts.nix and its service in service.nix)
}
