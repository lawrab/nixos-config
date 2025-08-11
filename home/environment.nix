# environment.nix - User environment variables and shell configuration
{ ... }:
{
  # Set session variables for user applications
  home.sessionVariables = {
    # Wayland compatibility (moved from system environment.nix for user context)
    MOZ_ENABLE_WAYLAND = "1";       # Firefox uses Wayland
    NIXOS_OZONE_WL = "1";           # Chromium/Electron use Wayland
    
    # Dark mode theming
    BRAVE_FLAGS = "--enable-features=WebUIDarkMode --force-dark-mode";
    GTK_THEME = "Adwaita:dark";
    QT_STYLE_OVERRIDE = "Adwaita-dark";
  };

  # Shell initialization for environment variables
  programs.bash.initExtra = ''
    # Source user environment variables if the file exists
    [ -f ~/.env ] && source ~/.env
  '';
  
  # Note: zsh initialization moved to shell.nix to avoid conflicts
}