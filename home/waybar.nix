# home/waybar.nix
{pkgs, pkgs-unstable, theme, ...}:
{
  programs.waybar = {
    enable = true;
    package = pkgs-unstable.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        spacing = 4;
        reload_style_on_change = true;
        output = "DP-3";  # Only show on right monitor, keep left monitor clean for gaming
        modules-left = [ "hyprland/workspaces" "mpris" "custom/music-viz" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "custom/services" "custom/vpn" "pulseaudio" "network" "cpu" "memory" "custom/temps" "clock" "tray" ];

        "hyprland/workspaces" = {
          "format" = "{id}";
          "on-click" = "activate";
          "format-icons" = {
            "default" = "";
            "active" = "";
            "urgent" = "";
          };
          "sort-by-number" = true;
        };
        
        "hyprland/window" = {
          "format" = "{}";
          "separate-outputs" = true;
          "max-length" = 50;
        };

        "mpris" = {
          "format" = "{player_icon}";
          "format-paused" = "";
          "format-stopped" = "";
          "player-icons" = {
            "default" = "";
            "mpv" = "🎵";
          };
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
          "format-wifi" = " ";
          "format-ethernet" = "󰈀";
          "format-disconnected" = "󰌙";
          "tooltip-format" = "{ifname}: {essid} via {gwaddr}";
        };

        "cpu" = {
          "format" = "󰻠 {usage}%";
          "interval" = 5;
          "tooltip" = true;
          "on-click" = "kitty -e btop";
        };

        "memory" = {
          "format" = "󰍛 {}%";
          "interval" = 10;
          "tooltip" = true;
          "on-click" = "kitty -e bash -c 'free -h; read'";
        };

        "custom/temps" = {
          "exec" = "waybar-temps";
          "format" = "{}";
          "interval" = 10;
          "tooltip" = true;
          "tooltip-format" = "CPU and GPU Temperatures";
          "on-click" = "kitty -e bash -c 'sensors; read'";
        };

        "custom/services" = {
          "exec" = "waybar-services";
          "format" = "{}";
          "interval" = 30;
          "tooltip" = true;
          "tooltip-format" = "Service Status (🤖=Ollama)";
          "on-click" = "kitty -e bash -c 'systemctl --no-pager status ollama; read'";
        };


        "custom/music-viz" = {
          "exec" = "waybar-music-viz";
          "format" = "{}";
          "interval" = 1;
          "tooltip" = false;
          "on-click" = "playerctl play-pause";
          "on-scroll-up" = "playerctl next";
          "on-scroll-down" = "playerctl previous";
        };

        "custom/vpn" = {
          "exec" = "waybar-vpn";
          "format" = "{}";
          "interval" = 5;
          "tooltip" = true;
          "tooltip-format" = "VPN Status - Click to toggle";
          "on-click" = "kitty -e bash -c 'if nmcli connection show --active | grep -q be-bru.prod.surfshark.comsurfshark_openvpn_udp; then vpn disconnect; else vpn connect; fi; read'";
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

      };
    };
    # Clean and elegant styling with Catppuccin
    style = ''
      @import "catppuccin.css";
      
      * {
        font-family: "JetBrainsMono Nerd Font", "JetBrains Mono", "Inter", "Noto Sans", sans-serif;
        font-size: 14px;
        font-weight: 500;
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
      #network, #clock, #mpris, #custom-services,
      #custom-music-viz, #custom-vpn {
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