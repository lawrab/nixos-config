# home/scripts.nix
{ pkgs, ... }:

let
  # writeShellScriptBin creates a derivation with an executable in bin/
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
        # slurp lets user select area, grim captures it
        # tee saves to file AND pipes to clipboard simultaneously
        grim -g "$(slurp)" -t png - | tee "$FILENAME" | wl-copy
        ;;
      full)
        # grim without -g captures entire screen
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

  # Combined temperature display for Waybar
  waybarTempsScript = pkgs.writeShellScriptBin "waybar-temps" ''
    #!/usr/bin/env bash
    
    # Get CPU temperature
    CPU_TEMP=$(cat /sys/class/hwmon/hwmon5/temp1_input 2>/dev/null)
    if [ -n "$CPU_TEMP" ]; then
      CPU_TEMP=$((CPU_TEMP / 1000))
    else
      CPU_TEMP="N/A"
    fi
    
    # Get GPU temperature
    GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)
    if [ -z "$GPU_TEMP" ]; then
      GPU_TEMP="N/A"
    fi
    
    # Format output
    echo "🌡️ $CPU_TEMP°C | $GPU_TEMP°C"
  '';

  # Find temperature sensors script
  findTempSensors = pkgs.writeShellScriptBin "find-temp-sensors" ''
    #!/usr/bin/env bash
    echo "=== Finding all temperature sensors ==="
    echo
    
    echo "--- Hardware Monitor Sensors ---"
    for sensor in /sys/class/hwmon/hwmon*/temp*_input; do
      if [ -f "$sensor" ]; then
        name_file="$(dirname "$sensor")/name"
        if [ -f "$name_file" ]; then
          name=$(cat "$name_file" 2>/dev/null)
        else
          name="unknown"
        fi
        temp=$(cat "$sensor" 2>/dev/null)
        temp_c=$((temp / 1000))
        echo "$sensor -> $name: $temp_c°C"
      fi
    done
    
    echo
    echo "--- DRM Card Sensors ---" 
    for sensor in /sys/class/drm/card*/device/hwmon/hwmon*/temp*_input; do
      if [ -f "$sensor" ]; then
        temp=$(cat "$sensor" 2>/dev/null)
        temp_c=$((temp / 1000))
        echo "$sensor -> GPU: $temp_c°C"
      fi
    done
    
    echo
    echo "--- NVIDIA GPU via nvidia-smi ---"
    if command -v nvidia-smi >/dev/null 2>&1; then
      nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | while read temp; do
        echo "nvidia-smi -> GPU: $temp°C"
      done
    else
      echo "nvidia-smi not available"
    fi
    
    echo
    echo "--- NVIDIA GPU via nvidia-settings ---"
    if command -v nvidia-settings >/dev/null 2>&1; then
      temp=$(nvidia-settings -q [gpu:0]/GPUCoreTemp -t 2>/dev/null)
      if [ -n "$temp" ]; then
        echo "nvidia-settings -> GPU: $temp°C"
      else
        echo "nvidia-settings query failed"
      fi
    else
      echo "nvidia-settings not available"
    fi
    
    echo
    echo "--- Check if NVIDIA modules are loaded ---"
    lsmod | grep nvidia || echo "No nvidia modules loaded"
  '';
in
{
  # Add the script package to your user's profile
  home.packages = [
    screenshotScript
    findTempSensors
    waybarTempsScript
  ];
}