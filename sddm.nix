# sddm.nix - SDDM Display Manager Configuration with Catppuccin Theme
{ config, pkgs, lib, ... }:

let
  # Custom Hyprland session that uses home-manager's start-hyprland wrapper
  hyprland-session = pkgs.writeTextDir "share/wayland-sessions/hyprland.desktop" ''
    [Desktop Entry]
    Name=Hyprland
    Comment=An intelligent dynamic tiling Wayland compositor
    Exec=start-hyprland
    Type=Application
    DesktopNames=Hyprland
    Keywords=tiling;wayland;compositor;
  '';
in
{
  # SDDM Display Manager Configuration
  services.displayManager.sddm = {
    enable = true;

    # Enable Wayland support
    wayland = {
      enable = true;
      compositor = "kwin";  # Can also use weston if kwin doesn't work
    };

    # Theme configuration
    theme = "catppuccin-mocha-mauve";

    # Use KDE6 version for better Wayland support
    package = pkgs.kdePackages.sddm;

    settings = {
      # General settings
      General = {
        DisplayServer = "wayland";
        GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell,XCURSOR_THEME=catppuccin-mocha-dark-cursors,XCURSOR_SIZE=24";
        InputMethod = "";  # Can be set to "qtvirtualkeyboard" if needed
      };

      # Theme settings
      Theme = {
        Current = "catppuccin-mocha-mauve";
        ThemeDir = "/run/current-system/sw/share/sddm/themes";
        FacesDir = "/var/lib/AccountsService/icons";
        CursorTheme = "catppuccin-mocha-dark-cursors";
        Font = "JetBrainsMono Nerd Font";
        EnableAvatars = true;
        DisableAvatarsThreshold = 7;
      };

      # Wayland specific settings
      Wayland = {
        CompositorCommand = "${pkgs.kdePackages.kwin}/bin/kwin_wayland --no-lockscreen --inputmethod maliit-keyboard";
        EnableHiDPI = true;
        SessionDir = "${hyprland-session}/share/wayland-sessions";
      };

      # Autologin (disabled by default, uncomment to enable)
      # Autologin = {
      #   User = "lrabbets";
      #   Session = "hyprland";
      # };

      # User settings
      Users = {
        DefaultPath = "/run/current-system/sw/bin";
        HideShells = "";
        HideUsers = "";
        MaximumUid = 29999; # Excludes nixbld build users (30001+)
        MinimumUid = 1000;
        RememberLastSession = true;
        RememberLastUser = true;
        ReuseSession = false;
      };
    };
  };

  # Ensure SDDM theme and dependencies are installed
  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve"; # Theme dir is catppuccin-<flavor>-<accent>
      fontSize = "9";
      background = "${./wallpapers/f1-3.png}";
      loginBackground = true;
    })
    catppuccin-cursors.mochaDark  # Cursor theme for SDDM/kwin
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtquick3d
    kdePackages.qtvirtualkeyboard
  ];

  # Set default session to Hyprland
  services.displayManager.defaultSession = "hyprland";
}
