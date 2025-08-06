# home/gtk.nix
{ pkgs, theme, ... }:

{
  # GTK Theme Configuration
  gtk = {
    enable = true;
    # Use Adwaita-dark as a base theme
    theme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    gtk3.extraCss = ''
      /* Override GTK colors using values from theme.nix */
      @define-color theme_bg_color #${theme.primary_background};
      @define-color theme_fg_color #${theme.primary_foreground};
      @define-color theme_selected_bg_color #${theme.primary_accent};
      @define-color theme_selected_fg_color #${theme.primary_background};
      @define-color window_bg_color #${theme.primary_background};
      @define-color window_fg_color #${theme.primary_foreground};
      @define-color view_bg_color #${theme.secondary_background};
      @define-color view_fg_color #${theme.primary_foreground};
      @define-color headerbar_bg_color #${theme.secondary_background};
      @define-color headerbar_fg_color #${theme.primary_foreground};
      @define-color popover_bg_color #${theme.secondary_background};
      @define-color popover_fg_color #${theme.primary_foreground};
      @define-color borders #${theme.window_border_inactive};
    '';

    gtk4.extraCss = ''
      /* Apply the same overrides for GTK4 applications */
      @define-color theme_bg_color #${theme.primary_background};
      @define-color theme_fg_color #${theme.primary_foreground};
      @define-color theme_selected_bg_color #${theme.primary_accent};
      @define-color theme_selected_fg_color #${theme.primary_background};
      @define-color window_bg_color #${theme.primary_background};
      @define-color window_fg_color #${theme.primary_foreground};
      @define-color view_bg_color #${theme.secondary_background};
      @define-color view_fg_color #${theme.primary_foreground};
      @define-color headerbar_bg_color #${theme.secondary_background};
      @define-color headerbar_fg_color #${theme.primary_foreground};
      @define-color popover_bg_color #${theme.secondary_background};
      @define-color popover_fg_color #${theme.primary_foreground};
      @define-color borders #${theme.window_border_inactive};
    '';
  };

  # Tell libadwaita applications (like Loupe and Shortwave) to prefer the dark theme.
  # This uses dconf, a configuration system for GNOME apps.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };
}