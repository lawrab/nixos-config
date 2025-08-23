# theme.nix - Official Catppuccin Mocha colors for unsupported applications
# 
# This theme file now serves as a fallback for applications that don't have
# direct catppuccin/nix module support (like wofi, thunar, obsidian, etc.)
# Most applications now use the official Catppuccin theming via catppuccin/nix modules.
# Colors based on official Catppuccin Mocha: https://catppuccin.com/palette
{
  # Official Catppuccin Mocha - Base colors
  base = "1e1e2e";        # Base background
  mantle = "181825";      # Slightly darker background  
  crust = "11111b";       # Darkest background
  
  # Text colors
  text = "cdd6f4";        # Primary text
  subtext1 = "bac2de";    # Secondary text
  subtext0 = "a6adc8";    # Muted text
  
  # Surface colors
  surface0 = "313244";    # Primary surface
  surface1 = "45475a";    # Secondary surface
  surface2 = "585b70";    # Tertiary surface
  
  # Overlay colors  
  overlay0 = "6c7086";    # Subtle overlay
  overlay1 = "7f849c";    # Medium overlay
  overlay2 = "9399b2";    # Prominent overlay

  # Accent colors from official Catppuccin Mocha
  mauve = "cba6f7";       # Purple accent
  blue = "89b4fa";        # Blue accent
  sapphire = "74c7ec";    # Sapphire accent
  sky = "89dceb";         # Sky blue
  teal = "94e2d5";        # Teal
  green = "a6e3a1";       # Green
  yellow = "f9e2af";      # Yellow
  peach = "fab387";       # Peach/orange
  maroon = "eba0ac";      # Maroon
  red = "f38ba8";         # Red
  pink = "f5c2e7";        # Pink
  flamingo = "f2cdcd";    # Flamingo
  rosewater = "f5e0dc";   # Rosewater
  lavender = "b4befe";    # Lavender

  # Legacy compatibility - mapped to official Catppuccin colors
  primary_background = "1e1e2e"; # base
  primary_foreground = "cdd6f4"; # text
  primary_accent = "cba6f7";     # mauve
  secondary_background = "313244"; # surface0
  secondary_foreground = "bac2de"; # subtext1
  secondary_accent = "f9e2af";     # yellow
  window_border_active = "cba6f7";   # mauve
  window_border_inactive = "45475a"; # surface1
  
  # Transparency effects using official Catppuccin base
  transparent_black = "rgba(30, 30, 46, 0.8)"; # Semi-transparent base
  frosted_glass = "rgba(30, 30, 46, 0.6)";     # Glass effect backgrounds
}