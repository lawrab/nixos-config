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
    theme = "catppuccin-mocha";

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
        Current = "catppuccin-mocha";
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
        MaximumUid = 60513;
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

  # Create SDDM configuration directory
  systemd.tmpfiles.rules = [
    "d /var/lib/sddm 0755 sddm sddm"
    "d /var/lib/sddm/.config 0755 sddm sddm"
    "d /var/lib/sddm/.config/hypr 0755 sddm sddm"
  ];

  # Create a basic Hyprland config for SDDM
  environment.etc."sddm/hyprland.conf" = {
    text = ''
      # Basic Hyprland configuration for SDDM
      monitor=,preferred,auto,1

      # Use integrated GPU for SDDM to save power
      env = WLR_DRM_DEVICES,/dev/dri/card0

      # Basic appearance with Catppuccin Mocha colors
      general {
        border_size = 2
        gaps_in = 5
        gaps_out = 10
        col.active_border = rgba(cba6f7ff)    # Catppuccin Mocha mauve
        col.inactive_border = rgba(313244ff)  # Catppuccin Mocha surface0
      }

      decoration {
        rounding = 10
        blur {
          enabled = true
          size = 3
          passes = 1
        }
      }

      # Basic animations
      animations {
        enabled = yes
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 3, myBezier
        animation = windowsOut, 1, 3, default, popin 80%
        animation = fade, 1, 3, default
      }
    '';
  };

  # Link the config to SDDM's home directory
  system.activationScripts.sddmConfig = ''
    if [ ! -f /var/lib/sddm/.config/hypr/hyprland.conf ]; then
      ln -sf /etc/sddm/hyprland.conf /var/lib/sddm/.config/hypr/hyprland.conf 2>/dev/null || true
    fi
  '';
}