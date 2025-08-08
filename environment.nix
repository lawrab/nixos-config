# environment.nix
{ lib, ... }:
let
  secretsPath = ./secrets.nix;
  secretsExist = builtins.pathExists secretsPath;
  secrets = if secretsExist then import secretsPath else {};
in
{
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    NIXOS_OZONE_WL = 1;
  } // lib.optionalAttrs secretsExist {
    ANTHROPIC_API_KEY = secrets.anthropic_api_key or "";
  };
}