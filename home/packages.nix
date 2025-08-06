{pkgs, ...}:

{
    home.packages = with pkgs; [
    # -- Screenshot Tools --
    grim            # The screenshot tool for Wayland
    slurp           # For selecting a region for grim
    wl-clipboard    # For copying the screenshot to the clipboard

    # Media
    loupe           # For image preview
    shortwave       # Internet radio player

    # -- Gaming Setup with Steam --
    steam
    protonup-qt
    gamemode
    gamescope
    vulkan-tools

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