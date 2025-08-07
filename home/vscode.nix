{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default.userSettings = {
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
    };

    # Add extensions here
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Official Python support from Microsoft
      ms-python.python
      bbenoist.nix
    ];
  };
}