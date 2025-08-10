{pkgs, pkgs-unstable, ...}:

{
    home.packages = with pkgs; [
    
    # ---- Utilities ----
    libnotify # For sending test notifications
    pwvucontrol # Pure Wayland PipeWire volume control
    xfce.thunar

    # ---- Fonts ----
    # Nix 24.05+ uses nerd-fonts.font-name syntax
    nerd-fonts.jetbrains-mono
    
    papirus-icon-theme

    eza  # A modern replacement for 'ls'
    bat  # A cat clone with syntax highlighting
    fzf  # A command-line fuzzy finder
    zoxide # A smarter cd command

    # -- Python --
    # withPackages creates a Python environment with specific packages
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
    pkgs-unstable.grim            # The screenshot tool for Wayland
    pkgs-unstable.slurp           # For selecting a region for grim
    pkgs-unstable.wl-clipboard    # For copying the screenshot to the clipboard
    pkgs-unstable.loupe           # For image preview
    pkgs-unstable.shortwave       # Internet radio player
    pkgs-unstable.steam
    pkgs-unstable.protonup-qt
    pkgs-unstable.gamemode
    pkgs-unstable.gamescope
    pkgs-unstable.vulkan-tools
    pkgs-unstable.obsidian
  ];
}