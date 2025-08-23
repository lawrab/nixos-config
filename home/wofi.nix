{ theme, ... }:

{
  programs.wofi = {
    enable = true;
    # Minimal custom styling - using official Catppuccin Mocha colors
    style = ''
      window {
        background-color: transparent;
        border: 2px solid #cba6f7; /* Catppuccin Mocha mauve */
        border-radius: 10px;
        font-family: "JetBrainsMono Nerd Font";
      }

      #input {
        background-color: #313244; /* Catppuccin Mocha surface0 */
        color: #cdd6f4; /* Catppuccin Mocha text */
        border: none;
        border-radius: 0px;
        margin: 5px;
        padding: 5px;
      }

      #inner-box {
        color: #cdd6f4; /* Catppuccin Mocha text */
        background-color: #1e1e2e; /* Catppuccin Mocha base */
        margin: 5px;
        border-radius: 5px;
      }

      #outer-box {
        margin: 0px;
        background-color: #1e1e2e; /* Catppuccin Mocha base */
        border-radius: 10px;
      }

      #scroll {
        background-color: #1e1e2e; /* Catppuccin Mocha base */
        margin: 5px;
        padding: 5px;
      }

      #entry {
        color: #cdd6f4; /* Catppuccin Mocha text */
        background-color: #313244; /* Catppuccin Mocha surface0 */
        padding: 10px;
      }

      #entry:selected {
        background-color: #cba6f7; /* Catppuccin Mocha mauve */
        color: #1e1e2e; /* Catppuccin Mocha base */
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