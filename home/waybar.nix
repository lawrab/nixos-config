# home/waybar.nix
{pkgs, theme, ...}:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 38;
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
          "swap-icon-label" = false;
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
          "icon-size" = 14;
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
    # Waybar uses CSS for styling with Catppuccin base theme
    style = ''
      @import "catppuccin.css";
      
      /* Custom overrides only for unique elements */
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12px;
      }

      /* Custom temperature warning animation */
      #temperature.critical {
        animation: temp-warning 1s ease-in-out infinite alternate;
      }

      @keyframes temp-warning {
        from { opacity: 1; }
        to { opacity: 0.7; }
      }

      /* Custom separator styling */
      #custom-separator {
        background: transparent;
        margin: 0 4px;
        padding: 0 2px;
        font-size: 14px;
        opacity: 0.4;
      }

      /* LaMetric music controls hover effect */
      #custom-lametric-music:hover {
        transition: all 0.3s ease;
      }
    '';
  };

  # Enable Catppuccin theming for Waybar with createLink mode
  # This creates ~/.config/waybar/catppuccin.css for import
  catppuccin.waybar = {
    enable = true;
    mode = "createLink";
  };
}