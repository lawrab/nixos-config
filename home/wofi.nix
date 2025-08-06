{ theme, ... }:

{
  programs.wofi = {
    enable = true;
    style = ''
      window {
        /* Make the main window transparent to see the box inside */
        background-color: transparent;
        border: 2px solid #${theme.red};
        border-radius: 10px;
        font-family: "JetBrainsMono Nerd Font";
      }

      #input {
        background-color: #${theme.dark_gray};
        color: #${theme.white};
        border: none;
        border-radius: 0px;
        margin: 5px;
        padding: 5px;
      }

      #inner-box {
        color: #${theme.white};
        background-color: #${theme.black};
        margin: 5px;
        border-radius: 5px;
      }

      #outer-box {
        margin: 0px;
        background-color: #${theme.black};
        border-radius: 10px;
      }

      #scroll {
        background-color: #${theme.black};
        margin: 5px;
        padding: 5px;
      }

      #entry {
        color: #${theme.white};
        background-color: #${theme.dark_gray};
        padding: 10px;
      }

      #entry:selected {
        background-color: #${theme.red};
        color: #${theme.black};
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