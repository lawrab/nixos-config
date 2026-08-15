# AzerothCore stack support: compose provider + persistence + firewall.
# The actual stack (compose.yaml, .env) lives in ~/azerothcore and is run
# manually with `podman compose up -d` / `stop` -- this module only wires up
# what NixOS needs to provide.
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.docker-compose ];

  # Keeps the user's systemd manager (and any already-running rootless
  # containers under it) alive after logout. Does NOT auto-start anything
  # at boot -- the stack is started/stopped manually with
  # `podman compose up -d` / `podman compose stop` in ~/azerothcore.
  users.users.lrabbets.linger = true;

  # Pin the compose provider explicitly so it doesn't silently depend on
  # PATH order between docker-compose and podman-compose (both installed
  # on this machine).
  virtualisation.containers.containersConf.settings.engine.compose_providers =
    [ "${pkgs.docker-compose}/bin/docker-compose" ];

  networking.firewall.allowedTCPPorts = [ 3724 8085 ];
}
