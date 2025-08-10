# home/wlogout.nix
{pkgs, pkgs-unstable, theme, ...}:

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
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
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
    
    style = ''
      window {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14pt;
        color: #${theme.primary_foreground};
        background-color: rgba(30, 30, 46, 0.8);
      }

      button {
        color: #${theme.primary_foreground};
        font-size: 20pt;
        background-color: #${theme.secondary_background};
        border: 2px solid #${theme.window_border_inactive};
        border-radius: 20px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.3);
        margin: 5px;
        transition: box-shadow 200ms ease-in-out, background-color 200ms ease-in-out;
      }

      button:focus,
      button:active,
      button:hover {
        color: #${theme.primary_accent};
        background-color: #${theme.primary_background};
        border-color: #${theme.primary_accent};
        box-shadow: 0 6px 12px 0 rgba(0, 0, 0, 0.4);
        outline-style: none;
      }

      #lock {
        background-image: image(url("${pkgs-unstable.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
        background-image: image(url("${pkgs-unstable.wlogout}/share/wlogout/icons/logout.png"));
      }

      #suspend {
        background-image: image(url("${pkgs-unstable.wlogout}/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
        background-image: image(url("${pkgs-unstable.wlogout}/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
        background-image: image(url("${pkgs-unstable.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
        background-image: image(url("${pkgs-unstable.wlogout}/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}