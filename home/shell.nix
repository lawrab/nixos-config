# home/shell.nix
{ pkgs, ... }:

{
  # Zsh Configuration
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # Add your aliases here
    shellAliases = {
      ls = "eza --icons";
      l = "eza --icons";
      ll = "eza -l --icons --git";
      la = "eza -la --icons --git";
      lt = "eza --tree --level=2 --icons";
      cat = "bat";
    };

    # Oh My Zsh provides themes and plugins for zsh
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ]; # Plugin names from oh-my-zsh repository
    };

    # initContent runs after zsh starts - for shell integrations
    initContent = ''
      eval "$(zoxide init zsh)"
    '';
  };

  # Starship Prompt Configuration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}