{pkgs, pkgs-unstable, ...}:

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

    papirus-icon-theme
    
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

    # -- Python --
    (python3.withPackages (ps: with ps; [
      # Core tools
      pip
      virtualenv

      # Common libraries for pet projects
      requests
      pylint
    ]))
  ] ++ [
    # -- Packages from unstable channel --
    # The unstable channel provides access to the latest versions of packages
    # that may not be available in the stable release. This is useful for:
    # - Newly released software (like claude-code)
    # - Development tools that need frequent updates
    # - Packages where you need cutting-edge features
    #
    # To use unstable packages:
    # 1. Add the package with pkgs-unstable prefix: pkgs-unstable.package-name
    # 2. Examples:
    #    pkgs-unstable.neovim        # Latest Neovim with newest features
    #    pkgs-unstable.nodejs_22     # Latest Node.js version
    #    pkgs-unstable.vscode        # VS Code with latest updates
    #    pkgs-unstable.discord       # Discord with latest features
    #    pkgs-unstable.firefox       # Firefox with newest security patches
    #
    # Note: Mixing stable and unstable packages is generally safe, but unstable
    # packages may occasionally break or have dependency conflicts.
    
    pkgs-unstable.claude-code  # Claude Code CLI - AI coding assistant from Anthropic
  ];
}