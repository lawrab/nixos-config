# home/waybar.nix
{pkgs, theme, ...}:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        modules-left = [ "hyprland/workspaces" "mpris" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "custom/separator" "network" "cpu" "memory" "custom/separator" "custom/temps" "custom/separator" "clock" "custom/separator" "tray" ];

        "hyprland/workspaces" = {
          "format" = "{id}";
          "on-click" = "activate";
          "format-icons" = {
            "default" = "";
            "active" = "";
          };
        };
        
        "hyprland/window" = {
          "format" = "{}";
          "separate-outputs" = true;
        };

        "mpris" = {
          "format" = "{player_icon} {title} - {artist}";
          "format-paused" = " {title}"; # Shows a play icon when paused
          "format-stopped" = ""; # Shows a stop icon when stopped
          "player-icons" = {
            "default" = ""; # Default music icon
            "mpv" = "🎵";
          };
          "max-length" = 40;
          "on-click" = "playerctl play-pause";
          "tooltip-format" = "{player}: {title} - {artist}";
        };

        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-muted" = " Muted";
          "format-icons" = {
            "default" = [ "" "" ];
          };
          "on-click" = "pwvucontrol";
        };

        "network" = {
          "format-wifi" = "{essid} ";
          "format-ethernet" = "";
          "format-disconnected" = "";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "on-click" = "nm-connection-editor";
        };

        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = true;
        };

        "memory" = {
          "format" = "{}% ";
          "tooltip" = true;
        };

        "custom/temps" = {
          "exec" = "waybar-temps";
          "format" = "{}";
          "interval" = 5;
          "tooltip" = true;
          "tooltip-format" = "CPU and GPU Temperatures";
        };
        
        "clock" = {
          "format" = "{:%H:%M}";
          "tooltip-format" = "<big>{:%A, %d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
        };
        
        "tray" = {
          "icon-size" = 18;
          "spacing" = 10;
        };

        "custom/separator" = {
          "format" = "|";
          "interval" = "once";
          "tooltip" = false;
        };
      };
    };
    # Waybar uses CSS for styling - standard CSS properties apply
    style = ''
      * {
        border: none;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background-color: ${theme.frosted_glass};
        color: #${theme.primary_foreground};
      }

      #workspaces {
        background-color: #${theme.secondary_background};
        margin: 5px;
        padding: 0px 5px;
        border-radius: 10px;
      }
      
      #workspaces button {
        color: #${theme.secondary_foreground};
        padding: 0px 5px;
      }

      #workspaces button.active {
        color: #${theme.primary_accent};
      }

      #workspaces button:hover {
        color: #${theme.primary_foreground};
      }
      
      #window {
        font-weight: bold;
      }

      /* System info modules */
      #pulseaudio,
      #network,
      #cpu,
      #memory {
        background-color: #${theme.secondary_background};
        padding: 0 12px;
        margin: 5px 2px;
        border-radius: 8px;
      }

      /* Combined temperature module */
      #custom-temps {
        background-color: #${theme.secondary_background};
        padding: 0 12px;
        margin: 5px 2px;
        border-radius: 8px;
      }

      /* Temperature warning colors */
      #temperature.critical {
        background-color: #ff6b6b;
        color: #ffffff;
        animation: temp-warning 1s ease-in-out infinite alternate;
      }

      @keyframes temp-warning {
        from { background-color: #ff6b6b; }
        to { background-color: #ff5252; }
      }

      #clock {
        background-color: #${theme.secondary_background};
        padding: 0 15px;
        margin: 5px 8px;
        border-radius: 10px;
        font-weight: bold;
      }

      #tray {
        background-color: #${theme.secondary_background};
        padding: 0 8px;
        margin: 5px 8px;
        border-radius: 10px;
      }

      /* Custom separator styling */
      #custom-separator {
        color: #${theme.window_border_inactive};
        background: transparent;
        margin: 0 4px;
        padding: 0 2px;
        font-size: 16px;
        opacity: 0.6;
      }

      /* Left modules styling */
      #mpris {
        background-color: #${theme.secondary_background};
        padding: 0 12px;
        margin: 5px 8px 5px 0px;
        border-radius: 8px;
      }
    '';
  };
}