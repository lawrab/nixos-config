{pkgs, pkgs-unstable, ...}:

{
  home.packages =
    # Core System Utilities (Stable)
    (with pkgs; [
      libnotify          # Desktop notifications
      pwvucontrol        # PipeWire volume control
      btop               # System monitor
      lm_sensors         # Hardware sensors
      nvtopPackages.nvidia # GPU monitoring for btop
    ]) ++

    # File Manager (Stable)
    (with pkgs; [
      xfce.thunar              # GUI file manager with drag-and-drop
      xfce.thunar-volman       # Automatic device management
      xfce.thunar-archive-plugin  # Archive file support
    ]) ++
    
    # CLI Tools (Stable) - themed with Catppuccin
    (with pkgs; [
      eza                # Modern 'ls' replacement
      bat                # Modern 'cat' with syntax highlighting
      fzf                # Fuzzy finder
      zoxide             # Smart 'cd' command
      gh                 # GitHub CLI
    ]) ++
    
    # Fonts and Themes (Stable)
    (with pkgs; [
      nerd-fonts.jetbrains-mono  # Programming font with icons
      # papirus-icon-theme - provided by Catppuccin
      libsForQt5.qtstyleplugin-kvantum # Qt theme engine for Catppuccin
      qt6Packages.qtstyleplugin-kvantum # Qt6 theme engine
    ]) ++
    
    
    # Essential Development Tools (Unstable - Latest Features)
    (with pkgs-unstable; [
      python3            # Python interpreter
      uv                 # Python tool runner (pipx alternative)
      nodejs             # JavaScript runtime
    ]) ++
    
    # Media and Screenshot Tools (Unstable)
    (with pkgs-unstable; [
      grim               # Wayland screenshot tool
      slurp              # Screen area selection
      wl-clipboard       # Wayland clipboard
      cliphist           # Clipboard history manager
      loupe              # Image viewer
    ]) ++
    
    # Gaming (Unstable - Latest Compatibility)
    # Note: Steam is configured in configuration.nix with programs.steam for GE-Proton support
    (with pkgs-unstable; [
      gamemode           # Game performance optimization
      gamescope          # Gaming compositor
      vulkan-tools       # Graphics debugging tools
      prismlauncher      # Minecraft launcher (maintained alternative)
      wowup-cf           # World of Warcraft addon manager (CurseForge)
      r2modman           # Thunderstore mod manager (Risk of Rain 2, Lethal Company, etc.)
    ]) ++

    # Productivity Applications (Unstable)
    (with pkgs-unstable; [
      claude-code
      obsidian           # Note-taking and knowledge management
    ]) ++
    
    # Communication (Unstable)
    (with pkgs-unstable; [
      discord            # Voice and text chat
      mumble             # Low-latency voice chat
    ]) ++
    
    # Audio Production Tools (Mixed)
    (with pkgs; [
      audacity           # Free audio editor
      sox                # Sound processing library
      alsa-utils         # ALSA utilities (PipeWire compatible)
    ]) ++
    (with pkgs-unstable; [
      reaper             # Digital audio workstation
      ffmpeg-full        # Comprehensive media conversion
      vlc                # Media player with codec support
    ]);
}
