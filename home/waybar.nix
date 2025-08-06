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
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "clock" "tray" ]; # Moved tray to the end

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

        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-muted" = " Muted";
          "format-icons" = {
            "default" = [ "" "" ];
          };
          "on-click" = "pavucontrol";
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
        
        "clock" = {
          "format" = "{:%H:%M}";
          "tooltip-format" = "<big>{:%A, %d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
        };
        
        "tray" = {
          "icon-size" = 18;
          "spacing" = 10;
        };
      };
    };
    # A complete CSS overhaul for a professional look
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

      /* Style for all modules on the right */
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #clock,
      #tray {
        background-color: #${theme.secondary_background};
        padding: 0 12px;
        margin: 5px 0px;
      }
      
      /* Add spacing between the right modules */
      #pulseaudio { margin-left: 8px; border-radius: 10px 0 0 10px; }
      #network { margin-left: 0px; }
      #cpu { margin-left: 0px; }
      #memory { margin-left: 0px; }
      #clock { margin-left: 0px; }
      #tray { margin-left: 8px; border-radius: 10px; }
    '';
  };
}