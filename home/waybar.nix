# home/waybar.nix
{pkgs, theme, ...}:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 48;
        modules-left = [ "hyprland/workspaces" "mpris" "custom/lametric-music" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "custom/separator" "network" "cpu" "memory" "custom/separator" "custom/temps" "custom/separator" "clock" "custom/separator" "tray" ];

        "hyprland/workspaces" = {
          "format" = "{id}";
          "on-click" = "activate";
          "format-icons" = {
            "default" = "";
            "active" = "";
            "urgent" = "";
          };
          "sort-by-number" = true;
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
        };

        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = true;
          "on-click" = "kitty -e btop";
        };

        "memory" = {
          "format" = "{}% ";
          "tooltip" = true;
          "on-click" = "kitty -e bash -c 'free -h; read'";
        };

        "custom/temps" = {
          "exec" = "waybar-temps";
          "format" = "{}";
          "interval" = 5;
          "tooltip" = true;
          "tooltip-format" = "CPU and GPU Temperatures";
          "on-click" = "kitty -e bash -c 'sensors; read'";
        };
        
        "clock" = {
          "format" = "{:%H:%M}";
          "tooltip-format" = "<big>{:%A, %d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          "actions" = {
            "on-click" = "mode";
          };
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
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

        "custom/lametric-music" = {
          "format" = "♪ {}";
          "exec" = "echo 'LaMetric'";
          "interval" = "once";
          "tooltip" = true;
          "tooltip-format" = "LaMetric Music Controls - Click for options";
          "on-click" = "lametric-music play";
          "on-click-right" = "lametric-music stop";
          "on-scroll-up" = "lametric-music next";
          "on-scroll-down" = "lametric-music prev";
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
        padding: 2px 8px;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
      }
      
      #workspaces button {
        color: #${theme.secondary_foreground};
        padding: 4px 8px;
        margin: 0 2px;
        border-radius: 8px;
        background: transparent;
        transition: all 0.3s ease;
        min-width: 24px;
        font-weight: 500;
        border: 1px solid transparent;
      }

      #workspaces button.active {
        color: #${theme.primary_foreground};
        background-color: #${theme.primary_accent};
        border: 2px solid #${theme.primary_accent};
        font-weight: bold;
        box-shadow: 0 0 10px rgba(233, 69, 96, 0.6);
      }

      #workspaces button:hover {
        color: #${theme.primary_foreground};
        background-color: rgba(255, 255, 255, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.3);
      }

      #workspaces button.urgent {
        color: #ffffff;
        background-color: #ff6b6b;
        border: 2px solid #ff5252;
        font-weight: bold;
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

      #custom-lametric-music {
        background-color: #${theme.secondary_background};
        padding: 0 12px;
        margin: 5px 8px 5px 0px;
        border-radius: 8px;
        color: #${theme.primary_accent};
        font-weight: bold;
      }

      #custom-lametric-music:hover {
        background-color: rgba(233, 69, 96, 0.2);
        transition: all 0.3s ease;
      }
    '';
  };

}