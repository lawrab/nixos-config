{ theme, ... }:

{
    programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      # Kitty uses hex colors without the # prefix in Nix config
      foreground = "#${theme.primary_foreground}";
      background = "#${theme.primary_background}";
      selection_background = "#${theme.secondary_background}";
      cursor = "#${theme.primary_accent}";

      # ANSI color palette (only defining essential ones)
      color0 = "#${theme.primary_background}";   # Black
      color1 = "#${theme.primary_accent}";       # Red
      color8 = "#${theme.secondary_background}"; # Bright black
      color15 = "#${theme.primary_foreground}";  # Bright white

      background_opacity = "0.85";
    };
  };
}