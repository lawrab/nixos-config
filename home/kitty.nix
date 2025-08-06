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
      foreground = "#${theme.primary_foreground}";
      background = "#${theme.primary_background}";
      selection_background = "#${theme.secondary_background}";
      cursor = "#${theme.primary_accent}";

      # Set the color palette for the terminal
      color0 = "#${theme.primary_background}";
      color1 = "#${theme.primary_accent}";
      color8 = "#${theme.secondary_background}";
      color15 = "#${theme.primary_foreground}";

      background_opacity = "0.85";
    };
  };
}