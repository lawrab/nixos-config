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
    # Configure starship to show zoxide status
    settings = {
      zoxide = {
        disabled = false;
        show_score = true;
        format = "󰄨 [$score]($style) ";
      };
    };
  };
}