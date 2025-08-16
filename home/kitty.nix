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

      # ANSI color palette with proper contrast for autosuggestions
      color0 = "#${theme.primary_background}";   # Black
      color1 = "#${theme.primary_accent}";       # Red
      color2 = "#32d74b";                        # Green
      color3 = "#${theme.secondary_accent}";     # Yellow/Gold
      color4 = "#007aff";                        # Blue
      color5 = "#af52de";                        # Magenta
      color6 = "#5ac8fa";                        # Cyan
      color7 = "#${theme.secondary_foreground}"; # Light gray
      color8 = "#666680";                        # Bright black (autosuggestion color)
      color9 = "#${theme.primary_accent}";       # Bright red
      color10 = "#32d74b";                       # Bright green
      color11 = "#${theme.secondary_accent}";    # Bright yellow
      color12 = "#007aff";                       # Bright blue
      color13 = "#af52de";                       # Bright magenta
      color14 = "#5ac8fa";                       # Bright cyan
      color15 = "#${theme.primary_foreground}";  # Bright white

      background_opacity = "0.85";
    };
  };
}