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
      # The tiler sizes windows; a remembered "maximized" state made new windows
      # open maximized, which Hyprland refuses to move between monitors
      remember_window_size = "no";
    };
  };

  # Enable Catppuccin theming for Kitty
  catppuccin.kitty.enable = true;
}