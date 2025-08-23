{ pkgs-unstable, ... }:

{
  programs.vscode = {
    enable = true;

    # VSCode profiles separate settings/extensions per workflow
    profiles.default.userSettings = {
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
    };

    # Extensions are managed declaratively - no manual installation
    profiles.default.extensions = with pkgs-unstable.vscode-extensions; [
      ms-python.python # Official Microsoft Python extension
      bbenoist.nix     # Nix language support
    ];
  };

  # Enable Catppuccin theming for VS Code
  catppuccin.vscode.profiles.default.enable = true;
}