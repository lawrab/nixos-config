{ pkgs-unstable, ... }:
{
  home.packages = [
    pkgs-unstable._1password-cli
    pkgs-unstable._1password-gui
  ];
}