{pkgs, theme, ...}:
{
  programs.waybar = {
    enable = true;

    # package = pkgs.waybar.withFeatures [ "hyprland" ];
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "tray" "pulseaudio" "network" "cpu" "memory" "clock" ];
        
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
        };

        "hyprland/submap" ={
          "format" = "mode: {}";
          "tooltip" = false;
        };

        "tray" = {
          "icon-size" = 18;
          "spacing" = 10;
        };

        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-muted" = "";
          "format-icons" = {
            "default" = [ "" "" ];
          };
          "on-click" = "pavucontrol";
        };

        "network" = {
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = " Connected";
          "format-disconnected" = "Disconnected";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "on-click" = "nm-connection-editor";
        };

        "clock" = {
          "format" = "{:%H:%M }";
          "format-alt" = "{:%A, %d %B %Y}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

      };
    };
    # Add some basic styling
    style = ''
      * {
        border: none;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        color: #${theme.primary_foreground};
      }

      window#waybar {
        background-color: ${theme.frosted_glass};
        color: #${theme.primary_foreground};
        transition-property: background-color;
        transition-duration: .5s;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #${theme.primary_foreground};
        border-radius: 0px;
      }

      #workspaces button.active {
        background-color: #${theme.primary_accent};
        color: #${theme.primary_background};
      }

      #workspaces button:hover {
        background: #${theme.secondary_background};
      }

      #submap {
        background-color: #${theme.primary_accent};
        color: #${theme.primary_background};
        padding: 0 8px;
        margin: 4px 0px;
        border-radius: 10px;
      }
    '';
  };
}