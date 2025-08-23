# home/waybar.nix
{pkgs, theme, ...}:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        modules-left = [ "hyprland/workspaces" "mpris" "custom/lametric-music" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "custom/temps" "clock" "tray" ];

        "hyprland/workspaces" = {
          "format" = "{id}";
          "on-click" = "activate";
          "format-icons" = {
            "default" = "";
            "active" = "";
            "urgent" = "";
          };
          "sort-by-number" = true;
          "swap-icon-label" = false;
        };
        
        "hyprland/window" = {
          "format" = "{}";
          "separate-outputs" = true;
          "max-length" = 50;
        };

        "mpris" = {
          "format" = "{player_icon} {title} - {artist}";
          "format-paused" = " {title}";
          "format-stopped" = "";
          "player-icons" = {
            "default" = "";
            "mpv" = "🎵";
          };
          "max-length" = 40;
          "on-click" = "playerctl play-pause";
          "tooltip-format" = "{player}: {title} - {artist}";
        };

        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-muted" = " Muted";
          "format-icons" = {
            "default" = [ "" "" "" ];
          };
          "on-click" = "pwvucontrol";
        };

        "network" = {
          "format-wifi" = " {essid}";
          "format-ethernet" = "";
          "format-disconnected" = "";
          "tooltip-format" = "{ifname} via {gwaddr}";
        };

        "cpu" = {
          "format" = "󰻠 {usage}%";
          "interval" = 2;
          "tooltip" = true;
          "on-click" = "kitty -e btop";
        };

        "memory" = {
          "format" = "󰍛 {}%";
          "interval" = 5;
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
          "format" = " {:%H:%M}";
          "tooltip-format" = "<big>{:%A, %d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
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
          "icon-size" = 16;
          "spacing" = 10;
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
    # Clean and elegant styling with Catppuccin
    style = ''
      @import "catppuccin.css";
      
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
        border: none;
      }

      window#waybar {
        background-color: @base;
        color: @text;
        padding: 4px 8px;
      }

      #workspaces button {
        padding: 4px 8px;
        margin: 4px 2px;
        background: transparent;
        color: @subtext0;
      }

      #workspaces button.active {
        background: @mauve;
        color: @base;
        border-radius: 4px;
      }

      #workspaces button:hover {
        background: @surface1;
        color: @text;
        border-radius: 4px;
      }

      #cpu, #memory, #custom-temps, #pulseaudio, 
      #network, #clock, #mpris, #custom-lametric-music {
        padding: 4px 10px;
        margin: 4px 3px;
        background: @surface0;
        color: @text;
        border-radius: 4px;
      }

      #custom-temps.critical {
        background: @red;
        color: @base;
        animation: temp-warning 1s ease-in-out infinite alternate;
      }

      @keyframes temp-warning {
        from { opacity: 1; }
        to { opacity: 0.7; }
      }

      #window {
        background: transparent;
        color: @subtext1;
        font-style: italic;
      }

      #tray {
        padding: 4px 10px;
        margin: 4px 3px;
        background: @surface0;
        border-radius: 4px;
      }
    '';
  };

  # Enable Catppuccin theming for Waybar
  catppuccin.waybar = {
    enable = true;
    mode = "createLink";
  };
}