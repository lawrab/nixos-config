# ollama.nix - Local AI model server with CUDA acceleration
#
# WARNING: This triggers a very long build time (potentially an hour) on first install
# because it compiles the entire CUDA toolkit from source if pre-built binaries
# aren't available for your system.
#
{ pkgs, ... }:

{
  # Ollama service for running local LLMs (Llama, Mistral, etc.)
  services.ollama = {
    enable = true;
    acceleration = "cuda"; # Requires NVIDIA GPU with CUDA drivers
  };

  # Grant user access to Ollama service
  # Note: User must also be added to "ollama" group in configuration.nix
  users.users.lrabbets.extraGroups = [ "ollama" ];
}