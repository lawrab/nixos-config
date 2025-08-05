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
    userEmail = "lrabbets@gmail.com";
  };

  home.stateVersion = "25.05";
}
