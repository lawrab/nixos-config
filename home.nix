# home.nix
{ pkgs, ... }:

{
  imports = [
    ./home/hyprland.nix
    ./home/waybar.nix
  ];

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # ---- Your Existing Apps ----
    firefox
    kitty
    wofi
    waybar
    vscode
    git
    
    # -- Gaming Setup with Steam --
    steam
    protonup-qt
    gamemode
    gamescope
    vulkan-tools

    # ---- New App: Notification Daemon ----
    mako
    
    # ---- Utilities ----
    libnotify # For sending test notifications
    pavucontrol # For audio control via Waybar
    xfce.thunar

    # ---- Fonts ----
    # CORRECTED: Use the new nerd-fonts package for JetBrains Mono
    nerd-fonts.jetbrains-mono
  ];

  programs.git = {
    enable = true;
    userName = "Lawrence Rabbets";
    userEmail = "lrabbets@gmail.com";
  };
}
