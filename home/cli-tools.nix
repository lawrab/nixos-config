# home/cli-tools.nix - Catppuccin theming for CLI tools
{ ... }:

{
  # Enable Catppuccin theming for supported CLI tools
  catppuccin = {
    bat.enable = true;         # Modern 'cat' with syntax highlighting
    btop.enable = true;        # System monitor
    fzf.enable = true;         # Fuzzy finder
  };
}