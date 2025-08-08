{ theme, ... }:

{
  programs.wofi = {
    enable = true;
    # Wofi styling uses CSS - selectors target specific UI elements
    style = ''
      window {
        /* Transparent background lets inner box show through */
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
      show = "drun"; # Application launcher mode
      width = "40%";
      lines = 5;
      prompt = "Launch:";
      layer = "overlay"; # Appears above other windows
    };
  };
}