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

  lametricNotifyScript = pkgs.writeShellScriptBin "lametric-notify" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Source environment variables from ~/.env
    if [ -f "$HOME/.env" ]; then
      source "$HOME/.env"
    fi

    # Check if IP and API key are set
    if [ -z "''${LAMETRIC_IP:-}" ]; then
      notify-send -u critical "LaMetric Error" "LAMETRIC_IP is not set in ~/.env"
      exit 1
    fi
    if [ -z "''${LAMETRIC_API_KEY:-}" ]; then
      notify-send -u critical "LaMetric Error" "LAMETRIC_API_KEY is not set in ~/.env"
      exit 1
    fi
    
    # --- Script Logic ---
    MESSAGE="$1"
    # Default icon - see https://developer.lametric.com/icons for full list
    ICON="a2867" # Notification icon (same as your working example)

    # JSON payload for the LaMetric API with critical priority (required for dimmed mode)
    JSON_PAYLOAD=" { \"priority\":\"critical\", \"model\": { \"frames\": [ { \"icon\":\"$ICON\", \"text\":\"$MESSAGE\"} ] } }"

    # Send the notification using curl with timeout and error handling
    echo "Sending notification to LaMetric at $LAMETRIC_IP..."
    echo "JSON Payload: $JSON_PAYLOAD"
    echo
    echo "DEBUG: You can test manually with:"
    echo "curl -X POST -u \"dev:$LAMETRIC_API_KEY\" -H \"Content-Type: application/json\" -d '$JSON_PAYLOAD' --connect-timeout 5 --max-time 10 --fail \"http://$LAMETRIC_IP:8080/api/v2/device/notifications\""
    echo
    
    if curl -X POST \
         -u "dev:$LAMETRIC_API_KEY" \
         -H "Content-Type: application/json" \
         -d "$JSON_PAYLOAD" \
         --connect-timeout 5 \
         --max-time 10 \
         --fail \
         --silent \
         --show-error \
         "http://$LAMETRIC_IP:8080/api/v2/device/notifications"; then
      echo "✓ Notification sent successfully"
    else
      echo "✗ Failed to send notification (check network/credentials)"
      exit 1
    fi
  '';

  # Script to create ~/.env file with user prompts
  createEnvScript = pkgs.writeShellScriptBin "create-env" ''
    #!/usr/bin/env bash
    
    ENV_FILE="$HOME/.env"
    
    echo "Creating environment variables file at $ENV_FILE"
    echo "Press Enter to skip any variable you don't want to set."
    echo
    
    # Create or backup existing file
    if [ -f "$ENV_FILE" ]; then
      echo "Backing up existing $ENV_FILE to $ENV_FILE.backup"
      cp "$ENV_FILE" "$ENV_FILE.backup"
    fi
    
    # Start with header
    cat > "$ENV_FILE" << 'EOF'
# User environment variables
# This file is sourced by bash and zsh on shell initialization
# Edit this file to add or modify environment variables

EOF
    
    # Prompt for each variable
    declare -A variables=(
      ["ANTHROPIC_API_KEY"]="Anthropic API key for Claude"
      ["LAMETRIC_API_KEY"]="LaMetric device API key"  
      ["LAMETRIC_IP"]="LaMetric device IP address"
    )
    
    for var in "''${!variables[@]}"; do
      echo -n "Enter $var (''${variables[$var]}): "
      read -r value
      
      if [ -n "$value" ]; then
        echo "export $var=\"$value\"" >> "$ENV_FILE"
        echo "✓ Set $var"
      else
        echo "⏭ Skipped $var"
      fi
    done
    
    echo
    echo "Environment file created at $ENV_FILE"
    echo "Variables will be available in new shell sessions."
    echo "Run 'source ~/.env' to load them in the current session."
  '';

  lametricMusicScript = pkgs.writeShellScriptBin "lametric-music" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Source environment variables from ~/.env
    if [ -f "$HOME/.env" ]; then
      source "$HOME/.env"
    fi

    # Check if IP and API key are set
    if [ -z "''${LAMETRIC_IP:-}" ]; then
      notify-send -u critical "LaMetric Error" "LAMETRIC_IP is not set in ~/.env"
      exit 1
    fi
    if [ -z "''${LAMETRIC_API_KEY:-}" ]; then
      notify-send -u critical "LaMetric Error" "LAMETRIC_API_KEY is not set in ~/.env"
      exit 1
    fi

    COMMAND="''${1:-}"
    if [ -z "$COMMAND" ]; then
      echo "Usage: $0 {play|stop|next|prev}"
      exit 1
    fi

    # Map commands to LaMetric radio API actions
    case "$COMMAND" in
      play)
        ACTION="radio.play"
        ;;
      stop)
        ACTION="radio.stop"
        ;;
      next)
        ACTION="radio.next"
        ;;
      prev)
        ACTION="radio.prev"
        ;;
      *)
        echo "Invalid command: $COMMAND"
        echo "Usage: $0 {play|stop|next|prev}"
        exit 1
        ;;
    esac

    # Get radio widget ID from the radio app
    RESPONSE=$(curl -s -u "dev:$LAMETRIC_API_KEY" \
      "http://$LAMETRIC_IP:8080/api/v2/device/apps/com.lametric.radio" 2>/dev/null)
    
    # Extract widget ID using grep and sed (more reliable than assuming position)
    WIDGET_ID=$(echo "$RESPONSE" | grep -o '"widgets"[^}]*"[a-f0-9]\{32\}"' | grep -o '[a-f0-9]\{32\}' | head -1)

    if [ -z "$WIDGET_ID" ]; then
      notify-send -u critical "LaMetric Error" "Could not find radio widget ID. Response: $RESPONSE"
      exit 1
    fi

    # JSON payload for the action
    JSON_PAYLOAD="{\"id\":\"$ACTION\"}"

    # Send the command
    if curl -X POST \
         -u "dev:$LAMETRIC_API_KEY" \
         -H "Content-Type: application/json" \
         -d "$JSON_PAYLOAD" \
         --connect-timeout 5 \
         --max-time 10 \
         --fail \
         --silent \
         --show-error \
         "http://$LAMETRIC_IP:8080/api/v2/device/apps/com.lametric.radio/widgets/$WIDGET_ID/actions"; then
      echo "✓ Music command '$COMMAND' sent successfully"
    else
      echo "✗ Failed to send music command"
      exit 1
    fi
  '';
  
in
{
  # Add the script package to your user's profile
  home.packages = [
    screenshotScript
    findTempSensors
    waybarTempsScript
    lametricNotifyScript
    createEnvScript
    lametricMusicScript
  ];
}