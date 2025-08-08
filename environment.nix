# environment.nix - System-wide environment variables and secrets management
{ lib, ... }:
let
  secretsPath = ./secrets.nix;
  secretsExist = builtins.pathExists secretsPath; # Check if secrets file exists
  secrets = if secretsExist then import secretsPath else {}; # Import secrets or empty set
in
{
  environment.sessionVariables = {
    # Wayland compatibility for browsers and Electron apps
    MOZ_ENABLE_WAYLAND = 1; # Firefox uses Wayland instead of XWayland
    NIXOS_OZONE_WL = 1; # Chromium/Electron apps use Wayland
  } // lib.optionalAttrs secretsExist { # Only add secrets if file exists
    ANTHROPIC_API_KEY = secrets.anthropic_api_key or ""; # Claude AI API key
  };
}