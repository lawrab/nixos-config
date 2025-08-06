# home/scripts.nix
{ pkgs, ... }:

let
  # This creates an executable script named "screenshot" in your path
  screenshotScript = pkgs.writeShellScriptBin "screenshot" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Directory where screenshots will be saved
    SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
    mkdir -p "$SCREENSHOT_DIR"

    # Filename with timestamp
    FILENAME="$SCREENSHOT_DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

    case "$1" in
      select)
        # Capture a selected area. The output of grim is piped to tee.
        # tee writes the image to the file AND passes it to wl-copy.
        grim -g "$(slurp)" -t png - | tee "$FILENAME" | wl-copy
        ;;
      full)
        # Capture the full screen, with the same tee process.
        grim -t png - | tee "$FILENAME" | wl-copy
        ;;
      *)
        echo "Usage: $0 {select|full}"
        exit 1
        ;;
    esac

    # Send a notification with the screenshot as the icon.
    # mako is already installed from your packages.nix
    notify-send "Screenshot Taken" "Saved as <i>$(basename "$FILENAME")</i> and copied to clipboard." -i "$FILENAME"
  '';
in
{
  # Add the script package to your user's profile
  home.packages = [
    screenshotScript
  ];
}