{ pkgs, lib, ...}:

let
  inherit (lib.generators) mkLuaInline toLua;
  lua = toLua { };

  mainMod = "SUPER";

  # Dispatcher helpers, so the bind list below reads like the hyprlang it replaced
  exec = cmd: "hl.dsp.exec_cmd(${lua cmd})";
  focusDir = dir: "hl.dsp.focus({ direction = ${lua dir} })";
  moveDir = dir: "hl.dsp.window.move({ direction = ${lua dir} })";
  resize = x: y: "hl.dsp.window.resize({ x = ${toString x}, y = ${toString y}, relative = true })";

  # Every keybinding: generates both the hl.bind calls and the SUPER+/ help menu
  binds = [
    # -- App Launchers --
    { keys = "${mainMod} + RETURN"; dsp = exec "kitty"; desc = "Terminal"; }
    { keys = "${mainMod} + D"; dsp = exec "wofi --show drun"; desc = "App launcher"; }
    { keys = "${mainMod} + E"; dsp = exec "thunar"; desc = "File manager"; }
    { keys = "${mainMod} + O"; dsp = exec "obsidian"; desc = "Obsidian"; }
    { keys = "${mainMod} + B"; dsp = exec "brave-dark"; desc = "Brave"; }
    { keys = "${mainMod} + SHIFT + B"; dsp = exec "firefox"; desc = "Firefox"; }
    { keys = "${mainMod} + L"; dsp = exec "hyprlock"; desc = "Lock screen"; }
    { keys = "${mainMod} + X"; dsp = exec "wlogout"; desc = "Power menu"; }

    # -- Screenshots --
    { keys = "Print"; dsp = exec "screenshot full"; desc = "Screenshot (full)"; }
    { keys = "SHIFT + Print"; dsp = exec "screenshot select"; desc = "Screenshot (area)"; }

    # -- Window Management --
    { keys = "${mainMod} + Q"; dsp = "hl.dsp.window.close()"; desc = "Close window"; }
    { keys = "${mainMod} + M"; dsp = "hl.dsp.exit()"; desc = "Exit Hyprland"; }
    { keys = "${mainMod} + F"; dsp = "hl.dsp.window.fullscreen()"; desc = "Fullscreen"; }
    { keys = "${mainMod} + SPACE"; dsp = ''hl.dsp.window.float({ action = "toggle" })''; desc = "Toggle floating"; }
    { keys = "${mainMod} + P"; dsp = "hl.dsp.window.pseudo()"; desc = "Pseudo-tile (dwindle)"; }
    { keys = "${mainMod} + SHIFT + P"; dsp = ''hl.dsp.layout("togglesplit")''; desc = "Toggle split (dwindle)"; }

    # -- Focus / Move with Arrow Keys --
    { keys = "${mainMod} + left"; dsp = focusDir "left"; desc = "Focus left"; }
    { keys = "${mainMod} + right"; dsp = focusDir "right"; desc = "Focus right"; }
    { keys = "${mainMod} + up"; dsp = focusDir "up"; desc = "Focus up"; }
    { keys = "${mainMod} + down"; dsp = focusDir "down"; desc = "Focus down"; }

    { keys = "${mainMod} + SHIFT + left"; dsp = moveDir "left"; desc = "Move window left"; }
    { keys = "${mainMod} + SHIFT + right"; dsp = moveDir "right"; desc = "Move window right"; }
    { keys = "${mainMod} + SHIFT + up"; dsp = moveDir "up"; desc = "Move window up"; }
    { keys = "${mainMod} + SHIFT + down"; dsp = moveDir "down"; desc = "Move window down"; }

    # -- Resize Windows --
    { keys = "${mainMod} + CTRL + left"; dsp = resize (-20) 0; desc = "Shrink width"; }
    { keys = "${mainMod} + CTRL + right"; dsp = resize 20 0; desc = "Grow width"; }
    { keys = "${mainMod} + CTRL + up"; dsp = resize 0 (-20); desc = "Shrink height"; }
    { keys = "${mainMod} + CTRL + down"; dsp = resize 0 20; desc = "Grow height"; }

    # -- Keybinding Helper --
    { keys = "${mainMod} + slash"; dsp = exec "hypr-keybinds"; desc = "Show keybindings"; }

    # -- Clipboard Manager --
    { keys = "${mainMod} + V"; dsp = exec "cliphist list | wofi --dmenu | cliphist decode | wl-copy"; desc = "Clipboard history"; }
  ]
  # -- Workspace Navigation -- (key 0 is workspace 10)
  ++ lib.concatMap (i:
    let key = toString (lib.mod i 10); in [
      { keys = "${mainMod} + ${key}"; dsp = "hl.dsp.focus({ workspace = ${toString i} })"; desc = "Workspace ${toString i}"; }
      { keys = "${mainMod} + SHIFT + ${key}"; dsp = "hl.dsp.window.move({ workspace = ${toString i} })"; desc = "Move to workspace ${toString i}"; }
    ]) (lib.range 1 10);

  # writeShellScriptBin creates an executable script in your PATH
  keybinds-script = pkgs.writeShellScriptBin "hypr-keybinds" ''
    echo -e "${lib.concatMapStringsSep "\\n" (b: "<b>${b.keys}</b>: ${b.desc}") binds}" | wofi --show dmenu --allow-markup -p "Hyprland Keybindings"
  '';

  # Run shell commands when a Hyprland event fires
  onEvent = event: cmds: {
    _args = [
      event
      (mkLuaInline "function()\n${lib.concatMapStrings (c: "  hl.exec_cmd(${lua c})\n") cmds}end")
    ];
  };

  windowRule = match: effects: effects // { inherit match; };

in # This is the end of the 'let' block and the start of your main config

{
    # Hyprland window manager configuration
    # The package comes from programs.hyprland in configuration.nix
    wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    # Generates hyprland.lua: each settings attribute becomes an hl.<name>(...) call
    configType = "lua";
    settings = {
      monitor = [
        { output = "DP-2"; mode = "1920x1080@144"; position = "0x0"; scale = 1; }
        { output = "DP-3"; mode = "1920x1080@144"; position = "1920x0"; scale = 1; }
      ];

      workspace_rule =
        [ { workspace = "1"; monitor = "DP-2"; default = true; } ]
        ++ map (i: { workspace = toString i; monitor = "DP-3"; } // lib.optionalAttrs (i == 2) { default = true; })
          (lib.range 2 10);

      on = [
        (onEvent "hyprland.start" [
          "goxlr-daemon"  # Headless GoXLR Mini control daemon
          "wl-paste --type text --watch cliphist store"  # Start clipboard history daemon
          "wl-paste --type image --watch cliphist store"  # Store image clipboard items
        ])
        # Nothing else ends the session on logout, so waybar and awww would
        # otherwise outlive the compositor and crash-loop on its dead socket
        (onEvent "hyprland.shutdown" [
          "systemctl --user stop graphical-session.target"
        ])
      ];

      bind = map (b: { _args = [ b.keys (mkLuaInline b.dsp) { description = b.desc; } ]; }) binds;

      config = {
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          allow_tearing = true; # Reduces input lag for gaming
          # colors is the Catppuccin palette, loaded by catppuccin.hyprland
          col = {
            active_border = mkLuaInline "colors.accent";
            inactive_border = mkLuaInline "colors.surface0";
          };
        };

        xwayland = {
          force_zero_scaling = true; # Fixes blurry XWayland fonts on NixOS
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 5;
            passes = 2;
          };
        };

        animations.enabled = true;
      };

      curve = {
        _args = [ "myBezier" { type = "bezier"; points = [ [ 0.05 0.9 ] [ 0.1 1.05 ] ]; } ];
      };

      animation = [
        { leaf = "windows"; enabled = true; speed = 7; bezier = "myBezier"; }
        { leaf = "windowsOut"; enabled = true; speed = 7; bezier = "default"; style = "popin 80%"; }
        { leaf = "border"; enabled = true; speed = 10; bezier = "default"; }
        { leaf = "fade"; enabled = true; speed = 7; bezier = "default"; }
        { leaf = "workspaces"; enabled = true; speed = 6; bezier = "default"; }
      ];

      window_rule = [
        # Disable rounded corners on fullscreen windows
        (windowRule { fullscreen = true; } { rounding = 0; })

        # Battle.net launcher - float fullscreen on main monitor
        (windowRule { title = "^(Battle.net)$"; } { float = true; fullscreen = true; workspace = "1"; })

        # World of Warcraft - fullscreen to prevent XWayland coordinate desync, no decorations
        (windowRule { title = "^(World of Warcraft)$"; } {
          fullscreen = true;
          rounding = 0;
          border_size = 0;
          no_blur = true;
          no_shadow = true;
          workspace = "1";
        })

        # Browser and editor assignments
        (windowRule { class = "^(brave-browser)$"; } { workspace = "2"; })
        (windowRule { class = "^([Gg]odot)$"; } { workspace = "1"; tile = true; })

        # Discord on workspace 3 (right monitor)
        (windowRule { class = "^([Dd]iscord)$"; } { workspace = "3"; })
      ];
    };
  };

  # Add our generated script to user packages
  home.packages = [ keybinds-script ];
}
