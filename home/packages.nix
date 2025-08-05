{pkgs, ...}:

{
    home.packages = with pkgs; [
    # ---- Your Existing Apps ----
    wofi
    
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
}