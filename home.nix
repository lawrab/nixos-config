# home.nix
{ pkgs, ... }:

{
  imports = [
    ./home/hyprland.nix
    ./home/waybar.nix
    ./home/packages.nix
  ];

  programs.git = {
    enable = true;
    userName = "Lawrence Rabbets";
    userEmail = "lawrab@users.noreply.github.com";
  };

  home.stateVersion = "25.05";
}
