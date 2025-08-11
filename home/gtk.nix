# home/gtk.nix
{ pkgs, theme, ... }:

let
  # Consolidated GTK CSS theme overrides using centralized theme colors
  themeCSS = ''
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
in
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

    # Apply consistent theming to both GTK3 and GTK4
    gtk3.extraCss = themeCSS;
    gtk4.extraCss = themeCSS;
  };

  # Tell libadwaita applications (like Loupe and Shortwave) to prefer the dark theme.
  # This uses dconf, a configuration system for GNOME apps.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
      "gtk-theme" = "Adwaita-dark";
    };
  };

  # Qt application theming
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "Adwaita-dark";
  };
}