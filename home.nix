# home.nix
{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # ---- Your Existing Apps ----
    firefox
    kitty
    wofi
    waybar
    vscode
    git
    
    # -- Gaming Setup with Steam --
    steam
    protonup-qt
    gamemode
    gamescope
    vulkan-tools

    # ---- New App: Notification Daemon ----
    mako
    
    # ---- Utilities ----
    libnotify # For sending test notifications
    pavucontrol # For audio control via Waybar

    # ---- Fonts ----
    # CORRECTED: Use the new nerd-fonts package for JetBrains Mono
    nerd-fonts.jetbrains-mono
  ];

  programs.git = {
    enable = true;
    userName = "Lawrence Rabbets";
    userEmail = "lrabbets@gmail.com";
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";
      
      exec-once = [ 
        "waybar" 
        "mako"
      ];

      "$mainMod" = "SUPER";
      
      bind = [
        "$mainMod, RETURN, exec, kitty"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, D, exec, wofi --show drun"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        allow_tearing = true;
      };
      decoration = { rounding = 10; };
      animations = {
        enabled = true; 
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
    };
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "tray" "mako" "pipewire" "network" "cpu" "memory" "clock" ];
        
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
        };

        "mako" = {
          "format" = "{count} ";
          "format-alt" = "";
          "tooltip" = true;
          "tooltip-format" = "Notifications";
          "on-click" = "makoctl restore";
          "on-click-right" = "makoctl dismiss -a";
          "on-click-middle" = "makoctl menu wofi -d";
        };

        "tray" = {
          "icon-size" = 18;
          "spacing" = 10;
        };

        "pipewire" = {
          "format" = "{volume}% {icon}";
          "format-muted" = "";
          "icons" = [ "" "" ];
          "on-click" = "pavucontrol";
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

      #mode {
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
