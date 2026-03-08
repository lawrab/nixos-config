# environment.nix - User environment variables and shell configuration
{ ... }:
{
  # Add ~/.local/bin to PATH for user-installed tools (e.g., Claude Code)
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Set session variables for user applications
  home.sessionVariables = {
    # Wayland compatibility (moved from system environment.nix for user context)
    MOZ_ENABLE_WAYLAND = "1";       # Firefox uses Wayland
    NIXOS_OZONE_WL = "1";           # Chromium/Electron use Wayland

    # Dark mode theming
    BRAVE_FLAGS = "--enable-features=WebUIDarkMode --force-dark-mode";
    GTK_THEME = "Adwaita:dark";
    # QT_STYLE_OVERRIDE managed by catppuccin Qt theming

    # UV Python configuration for NixOS compatibility
    UV_PYTHON_PREFERENCE = "only-system";

    # 1Password SSH agent configuration
    SSH_AUTH_SOCK = "~/.1password/agent.sock";
  };

  # Shell initialization for environment variables
  programs.bash.initExtra = ''
    # Source user environment variables if the file exists
    [ -f ~/.env ] && source ~/.env
  '';
  
  # Note: zsh initialization moved to shell.nix to avoid conflicts
}