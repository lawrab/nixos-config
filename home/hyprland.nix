{ pkgs, config, theme, ...}:

let
  # Self-referencing: access our own config to generate a help script
  keybinds = config.wayland.windowManager.hyprland.settings.bind;

  # Function to format each keybinding line for display
  format-keybind = bind:
    let
      # Split the line by comma, e.g., "$mainMod, RETURN, exec, kitty"
      parts = pkgs.lib.splitString "," bind;
      # Get the keys (first 2 parts), e.g., "$mainMod, RETURN"
      keys = pkgs.lib.concatStringsSep "," (pkgs.lib.take 2 parts);
      # Get the action (the rest), e.g., "exec, kitty"
      action = pkgs.lib.concatStringsSep "," (pkgs.lib.drop 2 parts);
    in
    # Replace variables and format for readability
    "<b>${pkgs.lib.replaceStrings [ "$mainMod" ] [ "SUPER" ] keys}</b>: ${action}";

  # Create the final list of formatted keybindings
  formatted-keybinds = pkgs.lib.map format-keybind keybinds;

  # writeShellScriptBin creates an executable script in your PATH
  keybinds-script = pkgs.writeShellScriptBin "hypr-keybinds" ''
    echo -e "${pkgs.lib.concatStringsSep "\\n" formatted-keybinds}" | wofi --show dmenu --allow-markup -p "Hyprland Keybindings"
  '';

in # This is the end of the 'let' block and the start of your main config

{
    wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";

      exec-once = [ 
        "waybar" 
        "hyprpaper"
      ];

      "$mainMod" = "SUPER";
      
      bind = [
        # -- App Launchers --
        "$mainMod, RETURN, exec, kitty"
        "$mainMod, D, exec, wofi --show drun"
        "$mainMod, E, exec, thunar"
        "$mainMod, O, exec, obsidian"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, R, exec, shortwave" 

        # -- Screenshots --
        ", Print, exec, screenshot full"
        "SHIFT, Print, exec, screenshot select"

        # -- Window Management --
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, F, fullscreen,"
        "$mainMod, SPACE, togglefloating,"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod SHIFT, P, togglesplit, # dwindle"

        # -- Focus / Move with Arrow Keys --
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # -- Resize Windows --
        "$mainMod CTRL, left, resizeactive, -20 0"
        "$mainMod CTRL, right, resizeactive, 20 0"
        "$mainMod CTRL, up, resizeactive, 0 -20"
        "$mainMod CTRL, down, resizeactive, 0 20"

        # -- Keybinding Helper --
        "$mainMod, slash, exec, hypr-keybinds"

        # -- Workspace Navigation --
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
        # Gradient borders: first color from theme, second hardcoded red
        "col.active_border" = "rgba(${theme.window_border_active}ee) rgba(cc0000ee) 45deg";
        "col.inactive_border" = "rgba(${theme.window_border_inactive}aa)";
        allow_tearing = true; # Reduces input lag for gaming
      };

      decoration = { 
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
      };

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

  # Add our generated script to user packages
  home.packages = [ keybinds-script ];
}