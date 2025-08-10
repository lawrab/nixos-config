# environment.nix - System-wide environment variables
{
  environment.sessionVariables = {
    # Wayland compatibility for browsers and Electron apps
    MOZ_ENABLE_WAYLAND = 1; # Firefox uses Wayland instead of XWayland
    NIXOS_OZONE_WL = 1; # Chromium/Electron apps use Wayland
  };
}