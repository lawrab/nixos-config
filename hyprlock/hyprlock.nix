{ pkgs, ... }:

{
  # Install the hyprlock package
  home.packages = with pkgs; [
    hyprlock
  ];

  # Link the configuration file to the correct path
  # Hyprlock looks for its config in ~/.config/hypr/hyprlock.conf
  home.file.".config/hypr/hyprlock.conf" = {
    source = ./hyprlock.conf;
  };
}