{ ... }:

{
  programs.firefox = {
    enable = true;

    # Define settings for a specific profile
    profiles.default = {
      isDefault = true; # Mark this as the default profile
      settings = {
        # These settings enable the built-in dark theme
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    };
    
    policies = {
      "FirefoxHome" = {
        "SearchEngine" = "DuckDuckGo";
        "TopSites" = [
          { "url" = "https://claude.ai"; }
          { "url" = "https://github.com"; }
          { "url" = "https://nixos.org"; }
        ];
      };
      "ExtensionSettings" = {
        "uBlock0@raymondhill.net" = {
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          "installation_mode" = "force_installed";
        };
      };
    };
  };
}