{ pkgs, ...}:

{
  # XDG MIME associations control which apps open file types system-wide
  # Use .desktop file names from /run/current-system/sw/share/applications/
  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/png" = "org.gnome.Loupe.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/webp" = "org.gnome.Loupe.desktop";
    "image/svg+xml" = "org.gnome.Loupe.desktop";
  };
}