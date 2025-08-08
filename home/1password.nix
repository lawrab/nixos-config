{ pkgs-unstable, ... }:
{
  home.packages = [
    # 1Password packages use underscores in Nix, not hyphens
    pkgs-unstable._1password-cli
    pkgs-unstable._1password-gui
  ];
}