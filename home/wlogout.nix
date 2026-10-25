# home/wlogout.nix
{lib, pkgs, pkgs-unstable, theme, ...}:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "logout";
        "action" = "hyprctl dispatch exit";
        "text" = "Logout";
        "keybind" = "e";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
    ];
    
    # Custom styling with Catppuccin colors, icons and rounded corners
    style = lib.mkForce ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 18px;
        font-weight: bold;
        background-image: none;
        outline: none;
        box-shadow: none;
        text-shadow: none;
        transition: all 0.3s ease;
      }

      window {
        background-color: rgba(30, 30, 46, 0.95);
      }

      button {
        background-color: rgba(49, 50, 68, 0.8);
        border: 2px solid rgba(108, 112, 134, 0.6);
        border-radius: 20px;
        margin: 15px;
        padding: 30px;
        color: #${theme.text};
        min-width: 180px;
        min-height: 180px;
        font-size: 24px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
      }

      button:focus, 
      button:active, 
      button:hover {
        background-color: rgba(108, 112, 134, 0.4);
        transform: scale(1.05);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.6);
      }

      #lock {
        background-color: rgba(249, 226, 175, 0.15);
        border-color: rgba(249, 226, 175, 0.5);
      }
      #lock:hover { 
        border-color: #${theme.yellow}; 
        color: #${theme.yellow};
        background-color: rgba(249, 226, 175, 0.25);
        box-shadow: 0 8px 25px rgba(249, 226, 175, 0.4);
      }
      #lock:before {
        content: "🔒";
        font-size: 48px;
        display: block;
        margin-bottom: 10px;
      }

      #logout {
        background-color: rgba(137, 180, 250, 0.15);
        border-color: rgba(137, 180, 250, 0.5);
      }
      #logout:hover { 
        border-color: #${theme.blue}; 
        color: #${theme.blue};
        background-color: rgba(137, 180, 250, 0.25);
        box-shadow: 0 8px 25px rgba(137, 180, 250, 0.4);
      }
      #logout:before {
        content: "🚪";
        font-size: 48px;
        display: block;
        margin-bottom: 10px;
      }

      #suspend {
        background-color: rgba(148, 226, 213, 0.15);
        border-color: rgba(148, 226, 213, 0.5);
      }
      #suspend:hover { 
        border-color: #${theme.teal}; 
        color: #${theme.teal};
        background-color: rgba(148, 226, 213, 0.25);
        box-shadow: 0 8px 25px rgba(148, 226, 213, 0.4);
      }
      #suspend:before {
        content: "⏸️";
        font-size: 48px;
        display: block;
        margin-bottom: 10px;
      }

      #shutdown {
        background-color: rgba(243, 139, 168, 0.15);
        border-color: rgba(243, 139, 168, 0.5);
      }
      #shutdown:hover { 
        border-color: #${theme.red}; 
        color: #${theme.red};
        background-color: rgba(243, 139, 168, 0.25);
        box-shadow: 0 8px 25px rgba(243, 139, 168, 0.4);
      }
      #shutdown:before {
        content: "⏻";
        font-size: 48px;
        display: block;
        margin-bottom: 10px;
      }

      #reboot {
        background-color: rgba(250, 179, 135, 0.15);
        border-color: rgba(250, 179, 135, 0.5);
      }
      #reboot:hover { 
        border-color: #${theme.peach}; 
        color: #${theme.peach};
        background-color: rgba(250, 179, 135, 0.25);
        box-shadow: 0 8px 25px rgba(250, 179, 135, 0.4);
      }
      #reboot:before {
        content: "🔄";
        font-size: 48px;
        display: block;
        margin-bottom: 10px;
      }
    '';
  };

  # Catppuccin theme disabled since we're using custom styling
  # catppuccin.wlogout.enable = true;
}