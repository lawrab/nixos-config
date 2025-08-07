# home/services.nix
{ pkgs, theme, ... }:

{
  # -- User-level System Services --
  
  # Enable the MPRIS proxy service so Waybar can see media players.
  services.mpris-proxy.enable = true;

  # Install playerctl to provide command-line controls for media players.
  home.packages = [ pkgs.playerctl ];

# Declaratively configure and enable the Mako notification daemon.
  services.mako = {
    enable = true;
    # All settings now live inside this 'settings' block.
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

  # -- Ollama Service --
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}