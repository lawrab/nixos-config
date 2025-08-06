# home.nix
{ pkgs, ... }:

{
  # Set the default shell for the user at the system level
  users.users.lrabbets.shell = pkgs.zsh;

  # Home Manager configuration for the user
  home-manager.users.lrabbets = {
    imports = [
      ./home/hyprland.nix
      ./home/waybar.nix
      ./home/packages.nix
      ./home/git.nix
      ./home/vscode.nix
      ./home/firefox.nix
      ./home/1password.nix
      ./home/kitty.nix
      ./home/wofi.nix
      ./home/shell.nix
      ./hyprpaper/hyprpaper.nix
      ./hyprlock/hyprlock.nix
    ];

    home.pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    home.stateVersion = "25.05";
  };
}