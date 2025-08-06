# theme/theme.nix
{
  # -- Core Palette --
  # Use these for the main UI elements.

  primary_background = "121212"; # Your original black
  primary_foreground = "EAEAEA"; # Your original white
  primary_accent = "D90429";      # Your original red

  # -- Secondary Palette --
  # For less prominent elements, like borders, inactive text, etc.

  secondary_background = "1c1c1c"; # Your original dark_gray
  secondary_foreground = "cccccc";   # A softer, off-white for less important text
  secondary_accent = "FFD700";       # A new gold/yellow for secondary highlights

  # -- UI Element-Specific Colors --
  # For more fine-grained control over your UI.

  window_border_active = "D90429";
  window_border_inactive = "1c1c1c";
  
  # -- Special Values --
  
  transparent_black = "rgba(0, 0, 0, 0.8)";
  frosted_glass = "rgba(0, 0, 0, 0.6)"; 
}