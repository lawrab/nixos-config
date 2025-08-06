# home/shell.nix
{ pkgs, ... }:

{
  # Zsh Configuration
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh for plugin management
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ]; # Add any other plugins you like here
    };

    # Initialize zoxide
    initContent = ''
      eval "$(zoxide init zsh)"
    '';
  };

  # Starship Prompt Configuration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    # You can customize your starship prompt here if you want
    # For now, we'll stick with the default which is already great.
    # settings = { ... };
  };
}