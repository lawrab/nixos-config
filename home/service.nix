# home/services.nix
{ pkgs, ... }:

{
  # -- User-level System Services --
  
  # Enable the MPRIS proxy service so Waybar can see media players.
  services.mpris-proxy.enable = true;

  # Install playerctl to provide command-line controls for media players.
  home.packages = [ pkgs.playerctl ];
}