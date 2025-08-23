{ ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.85";
    };
  };

  # Enable Catppuccin theming for Kitty
  catppuccin.kitty.enable = true;
}