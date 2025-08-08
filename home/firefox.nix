{ pkgs-unstable, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox;

    # Define settings for a specific profile
    profiles.default = {
      isDefault = true; # Mark this as the default profile
      settings = {
        # These settings enable the built-in dark theme
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    };
    
    # Policies enforce settings that users cannot change in Firefox UI
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
        # Extension IDs can be found at about:debugging#/runtime/this-firefox
        "uBlock0@raymondhill.net" = {
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          "installation_mode" = "force_installed"; # Prevents user removal
        };
      };
    };
  };
}