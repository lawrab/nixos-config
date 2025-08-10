# environment.nix - Home Manager environment variables including secrets
{ lib, ... }:
let
  secretsPath = ./secrets.nix;
  secretsExist = builtins.pathExists secretsPath;
  secrets = if secretsExist then import secretsPath else {};
in
{
  home.sessionVariables = lib.optionalAttrs secretsExist {
    ANTHROPIC_API_KEY = secrets.anthropic_api_key or "";
    LAMETRIC_API_KEY = secrets.lametric_api_key or "";
    LAMETRIC_IP = secrets.lametric_ip or "";
  };
}