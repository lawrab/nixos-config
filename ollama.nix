# ollama.nix
#
# This is an optional service. To enable it, uncomment its import
# statement in 'configuration.nix'.
#
{ pkgs, ... }:

{
  # -- Ollama Service for Local LLMs --
  # This service runs Ollama with CUDA acceleration for NVIDIA GPUs.
  # It's a heavy build, so it's kept optional.
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # Add any users who should have access to Ollama to this group.
  # Make sure the user is also added to this group in 'configuration.nix'
  users.users.lrabbets.extraGroups = [ "ollama" ];
}