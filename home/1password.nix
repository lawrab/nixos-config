{ pkgs-unstable, ... }:
{
  home.packages = [
    # 1Password packages use underscores in Nix, not hyphens
    pkgs-unstable._1password-cli
    pkgs-unstable._1password-gui
  ];

  # Enable gnome-keyring for 1Password secret storage
  # Only using secrets component - 1Password SSH agent handles SSH keys
  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

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
