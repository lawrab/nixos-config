{ theme, ... }:

{
    programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      # Use the colors from your theme.nix
      foreground = "#${theme.white}";
      background = "#${theme.black}";
      selection_background = "#${theme.dark_gray}";
      cursor = "#${theme.red}";

      # Set the color palette for the terminal
      color0 = "#${theme.black}";
      color1 = "#${theme.red}";
      color8 = "#${theme.dark_gray}";
      color15 = "#${theme.white}";

      background_opacity = "0.85";
    };
  };
}