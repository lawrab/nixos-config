{...}:

{
  programs.git = {
    enable = true;
    userName = "Lawrence Rabbets";
    userEmail = "lawrab@users.noreply.github.com";

    # Set Neovim as the editor specifically for Git
    extraConfig = {
      core.editor = "nvim";
    };
  };
}