# home.nix
{ pkgs, pkgs-unstable, ... }:

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
      ./home/scripts.nix
      ./home/default-apps.nix
      ./home/service.nix
      ./home/gtk.nix
      ./home/neovim.nix
      ./hyprpaper/hyprpaper.nix
      ./hyprlock/hyprlock.nix
    ];

    home.stateVersion = "25.05";
  };
}