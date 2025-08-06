{pkgs, ...}:

{
    home.packages = with pkgs; [
    # -- Gaming Setup with Steam --
    steam
    protonup-qt
    gamemode
    gamescope
    vulkan-tools

    mako
    obsidian
    
    # ---- Utilities ----
    libnotify # For sending test notifications
    pavucontrol # For audio control via Waybar
    xfce.thunar

    # ---- Fonts ----
    # CORRECTED: Use the new nerd-fonts package for JetBrains Mono
    nerd-fonts.jetbrains-mono

    eza  # A modern replacement for 'ls'
    bat  # A cat clone with syntax highlighting
    fzf  # A command-line fuzzy finder
    zoxide # A smarter cd command
  ];
}