# theme.nix - Centralized color scheme for the entire desktop
# 
# This theme is imported as a specialArg in flake.nix and passed to all modules.
# Change colors here and they'll update across Hyprland, Waybar, terminals, etc.
{
  # Core color palette - primary interface elements
  primary_background = "1a1a2e"; # Deep dark purple - main background
  primary_foreground = "e0e0e0"; # Soft white - main text color
  primary_accent = "e94560";      # Vibrant magenta/pink - active elements

  # Secondary palette - subtle UI elements
  secondary_background = "2a2a40"; # Lighter purple - secondary backgrounds
  secondary_foreground = "a0a0c0"; # Muted lavender - secondary text
  secondary_accent = "f0c430";     # Warm gold - highlights and warnings

  # Window manager specific colors
  window_border_active = "e94560";   # Active window border (matches primary_accent)
  window_border_inactive = "2a2a40"; # Inactive window border (matches secondary_background)
  
  # Transparency effects for modern UI
  transparent_black = "rgba(26, 26, 46, 0.8)"; # Semi-transparent overlays
  frosted_glass = "rgba(26, 26, 46, 0.6)";     # Glass effect backgrounds
}