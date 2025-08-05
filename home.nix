# home.nix
{ pkgs, ... }:

{
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     waybar = prev.waybar.overrideAttrs (oldAttrs: {
  #       # This enables experimental modules like hyprland
  #       mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  #     });
  #   })
  # ];

  imports = [
    ./home/hyprland.nix
    ./home/waybar.nix
    ./home/packages.nix
    ./home/git.nix
    ./home/vscode.nix
    ./home/firefox.nix
    ./home/1password.nix
    ./hyprpaper/hyprpaper.nix
  ];

  home.pointerCursor = {
    # You can choose a different cursor theme if you like
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  home.stateVersion = "25.05";
}
