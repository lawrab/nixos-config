# ollama.nix - Local AI model server with CUDA acceleration
#
# WARNING: This triggers a very long build time (potentially an hour) on first install
# because it compiles the entire CUDA toolkit from source if pre-built binaries
# aren't available for your system.
#
{ pkgs, pkgs-unstable, ... }:

{
  # Ollama service for running local LLMs (Llama, Mistral, etc.)
  services.ollama = {
    enable = true;
    acceleration = "cuda"; # Requires NVIDIA GPU with CUDA drivers
    package = pkgs-unstable.ollama; # Stable nixpkgs lags far behind upstream releases
    host = "0.0.0.0"; # Bind all interfaces so containers on their own podman
                       # bridge network (not host networking) can reach Ollama
                       # via the host's LAN IP instead of just 127.0.0.1.
  };

  # Grant user access to Ollama service
  # Note: User must also be added to "ollama" group in configuration.nix
  users.users.lrabbets.extraGroups = [ "ollama" ];
}