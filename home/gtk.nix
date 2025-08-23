# home/gtk.nix
{ lib, pkgs, ... }:

{
  # GTK Theme Configuration
  gtk = {
    enable = true;

    # iconTheme managed by Catppuccin kvantum module

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  # Tell libadwaita applications (like Loupe and Shortwave) to prefer the dark theme.
  # This uses dconf, a configuration system for GNOME apps.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };

  # Qt application theming with Catppuccin support
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Enable Catppuccin theming for Qt applications
  catppuccin.kvantum.enable = true;
}