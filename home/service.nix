# home/services.nix
{ pkgs, theme, ... }:

{
  # -- User-level System Services --
  
  # MPRIS proxy forwards D-Bus media control signals to Waybar
  services.mpris-proxy.enable = true;

  # playerctl provides CLI media controls (play, pause, next, etc.)
  home.packages = [ pkgs.playerctl ];

  # Mako is a Wayland notification daemon - replaces dunst on X11
  services.mako = {
    enable = true;
    # Settings go in a nested attrset, not top-level
    settings = {
      "background-color" = "#${theme.primary_background}";
      "text-color"       = "#${theme.primary_foreground}";
      "border-color"     = "#${theme.primary_accent}";
      "border-size"      = 2;
      "border-radius"    = 10;
      "default-timeout"  = 5000;
      "font"             = "JetBrainsMono Nerd Font 12";
    };
  };
}