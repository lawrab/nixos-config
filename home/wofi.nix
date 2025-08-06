{ theme, ... }:

{
  programs.wofi = {
    enable = true;
    style = ''
      window {
        /* Make the main window transparent to see the box inside */
        background-color: transparent;
        border: 2px solid #${theme.primary_accent};
        border-radius: 10px;
        font-family: "JetBrainsMono Nerd Font";
 }

      #input {
        background-color: #${theme.secondary_background};
        color: #${theme.primary_foreground};
        border: none;
        border-radius: 0px;
        margin: 5px;
        padding: 5px;
      }

      #inner-box {
        color: #${theme.primary_foreground};
        background-color: #${theme.primary_background};
        margin: 5px;
        border-radius: 5px;
      }

      #outer-box {
        margin: 0px;
        background-color: #${theme.primary_background};
        border-radius: 10px;
      }

      #scroll {
        background-color: #${theme.primary_background};
        margin: 5px;
        padding: 5px;
      }

      #entry {
        color: #${theme.primary_foreground};
        background-color: #${theme.secondary_background};
        padding: 10px;
      }

      #entry:selected {
        background-color: #${theme.primary_accent};
        color: #${theme.primary_background};
      }
    '';
    settings = {
      show = "drun";
      width = "40%";
      lines = 5;
      prompt = "Launch:";
      layer = "overlay";
    };
  };
}