{ pkgs, ... }:
{
  home.packages = [
    pkgs._1password-cli
    pkgs._1password-gui
  ];
}