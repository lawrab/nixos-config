# home.nix
{ pkgs, ... }:

{
  imports = [
    ./home/hyprland.nix
    ./home/waybar.nix
    ./home/packages.nix
    ./home/git.nix
    ./home/vscode.nix
  ];

  home.stateVersion = "25.05";
}
