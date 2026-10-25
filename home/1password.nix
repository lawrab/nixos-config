{ ... }:
{
  # The 1Password app and CLI are installed by the NixOS modules in configuration.nix

  # gnome-keyring for 1Password secret storage. PAM starts and unlocks the daemon at
  # login, but Hyprland doesn't run XDG autostart, so this `--start` is what hands the
  # unlocked daemon to the session bus. Without it you get a keyring unlock prompt.
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
