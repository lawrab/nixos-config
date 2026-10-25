{ ... }:
{
  # The 1Password app and CLI are installed by the NixOS modules in configuration.nix

  # SSH configuration for 1Password integration
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # Home Manager's implicit defaults are deprecated

    settings."*" = {
      # Use 1Password SSH agent
      IdentityAgent = "~/.1password/agent.sock";

      # Load keys from 1Password on demand
      AddKeysToAgent = "yes";

      # Use SSH key comments for better organization in 1Password
      IdentitiesOnly = true;
    };
  };
}
