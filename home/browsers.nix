{ pkgs, pkgs-unstable, ... }:

{
  # Firefox Configuration
  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox;

    profiles.default = {
      isDefault = true;
      settings = {
        # Enable dark theme for consistency with Brave
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        
        # Privacy and security settings to match Brave's defaults
        "privacy.trackingprotection.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        
        # Disable telemetry to match Brave's privacy focus
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        
        # Set DuckDuckGo as default search engine
        "browser.search.defaultenginename" = "ddg";
        "browser.urlbar.placeholderName" = "ddg";
        
        # Performance optimizations
        "browser.sessionstore.interval" = 15000;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.enable" = true;
        "browser.cache.memory.capacity" = 204800;
      };
      
      search = {
        default = "ddg";
        force = true; # Force DuckDuckGo as default
      };
      
      extensions = {
        force = true; # Acknowledge that this will override all previous extensions settings
      };
    };
    
    policies = {
      # Set Firefox home page configuration
      "FirefoxHome" = {
        "Search" = true;
        "TopSites" = [
          { "url" = "https://claude.ai"; }
          { "url" = "https://github.com"; }
          { "url" = "https://nixos.org"; }
        ];
      };
      
      # Set DuckDuckGo as default search engine via policy
      "SearchEngines" = {
        "Default" = "ddg";
        "PreventInstalls" = false;
      };
      
      # Privacy-focused policy settings to match Brave
      "DisableTelemetry" = true;
      "DisableFirefoxStudies" = true;
      "DisablePocket" = true;
      
      # Security settings
      "DisablePasswordReveal" = true;
      "PasswordManagerEnabled" = false; # Since we use 1Password
      
      # Extension management
      "ExtensionSettings" = {
        # uBlock Origin for ad blocking (similar to Brave's built-in blocker)
        "uBlock0@raymondhill.net" = {
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          "installation_mode" = "force_installed";
        };
      };
    };
  };

  # Brave Browser Configuration
  # Create a wrapper script that launches Brave with dark mode flags
  home.packages = [
    pkgs-unstable.brave
    (pkgs.writeShellScriptBin "brave-dark" ''
      exec ${pkgs-unstable.brave}/bin/brave \
        --enable-features=WebUIDarkMode \
        --force-dark-mode \
        --enable-force-dark \
        --force-prefers-color-scheme=dark \
        "$@"
    '')
  ];

  # Enable Catppuccin theming for Firefox
  catppuccin.firefox.enable = true;

  # Note: Brave configuration files are managed manually due to Home Manager conflicts
  # The brave-dark wrapper script provides automatic dark mode via command-line flags
  # Configure Brave manually after first launch:
  # 1. Go to Settings → Search engine → Set DuckDuckGo as default
  # 2. Privacy settings are already good (Brave defaults)
  # 3. Theme will follow system (dark mode) due to wrapper script flags
  # 4. Add bookmarks: Claude AI (https://claude.ai), GitHub, NixOS
}