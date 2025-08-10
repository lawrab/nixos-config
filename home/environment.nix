# environment.nix - Home Manager environment variables with shell-based secrets
{ ... }:
{
  # Source environment variables on shell initialization
  programs.bash.initExtra = ''
    # Source user environment variables if the file exists
    [ -f ~/.env ] && source ~/.env
  '';
  
  programs.zsh.initContent = ''
    # Source user environment variables if the file exists
    [ -f ~/.env ] && source ~/.env
  '';
}