{pkgs, pkgs-unstable, ...}:

{
  home.packages = 
    # Core System Utilities (Stable)
    (with pkgs; [
      libnotify          # Desktop notifications
      pwvucontrol        # PipeWire volume control
      xfce.thunar        # File manager
      btop               # System monitor
      lm_sensors         # Hardware sensors
    ]) ++
    
    # CLI Tools (Stable)
    (with pkgs; [
      eza                # Modern 'ls' replacement
      bat                # Modern 'cat' with syntax highlighting
      fzf                # Fuzzy finder
      zoxide             # Smart 'cd' command
    ]) ++
    
    # Fonts and Themes (Stable)
    (with pkgs; [
      nerd-fonts.jetbrains-mono  # Programming font with icons
      papirus-icon-theme         # Icon theme
    ]) ++
    
    # Development Environment (Stable)
    (with pkgs; [
      # Python with essential packages
      (python3.withPackages (ps: with ps; [
        pip virtualenv requests pylint
      ]))
    ]) ++
    
    # Development Tools (Unstable - Latest Features)
    (with pkgs-unstable; [
      claude-code        # AI coding assistant
    ]) ++
    
    # Media and Screenshot Tools (Unstable)
    (with pkgs-unstable; [
      grim               # Wayland screenshot tool
      slurp              # Screen area selection
      wl-clipboard       # Wayland clipboard
      loupe              # Image viewer
      cider              # Apple Music client
    ]) ++
    
    # Gaming (Unstable - Latest Compatibility)
    (with pkgs-unstable; [
      steam              # Gaming platform
      protonup-qt        # Proton version manager
      gamemode           # Game performance optimization
      gamescope          # Gaming compositor
      vulkan-tools       # Graphics debugging tools
    ]) ++
    
    # Productivity Applications (Unstable)
    (with pkgs-unstable; [
      obsidian           # Note-taking and knowledge management
    ]) ++
    
    # Communication (Unstable)
    (with pkgs-unstable; [
      discord            # Voice and text chat
    ]);
}