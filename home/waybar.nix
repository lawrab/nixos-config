{pkgs, ...}:
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
        modules-right = [ "tray" "custom/mako" "pulseaudio" "network" "cpu" "memory" "clock" ];
        
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
        };

        "hyprland/submap" ={
          "format" = "mode: {}";
          "tooltip" = false;
        };

        "custom/mako" = {
          exec = "makoctl count";
          exec-if = "pgrep mako";
          format = "{} ";
          format-alt = "";
          tooltip = true;
          tooltip-format = "Notifications";
          on-click = "makoctl restore";
          on-click-right = "makoctl dismiss -a";
          on-click-middle = "makoctl menu wofi -d";
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
      }

      window#waybar {
        background-color: rgba(26, 27, 38, 0.8);
        color: #cdd6f4;
        transition-property: background-color;
        transition-duration: .5s;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #cdd6f4;
        border-radius: 0px;
      }

      #workspaces button.active {
        background-color: #89b4fa;
        color: #1e1e2e;
      }

      #workspaces button:hover {
        background: #45475a;
      }

      #submap {
        background-color: #cba6f7;
        color: #1e1e2e;
        padding: 0 8px;
        margin: 4px 0px;
        border-radius: 10px;
      }

      .modules-right > * > * {
        padding: 0 8px;
        margin: 4px 0px;
      }
    '';
  };
}