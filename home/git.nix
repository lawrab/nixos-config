{...}:

{
  programs.git = {
    enable = true;
    userName = "Lawrence Rabbets";
    userEmail = "lawrab@users.noreply.github.com";

    # Set Neovim as the editor specifically for Git
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      diff.colorMoved = "default";
      merge.conflictStyle = "diff3";
      rerere.enabled = true;
    };

    # Git aliases for common operations
    aliases = {
      # Pretty log formats
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      lga = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all";
      ll = "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat";
      
      # Short status
      st = "status -s";
      
      # Common operations
      co = "checkout";
      br = "branch";
      ci = "commit";
      ca = "commit -a";
      cm = "commit -m";
      cam = "commit -am";
      
      # Diff shortcuts
      df = "diff";
      dc = "diff --cached";
      
      # Reset shortcuts
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      
      # Show what happened
      visual = "!gitk";
      
      # Stash shortcuts
      sl = "stash list";
      sa = "stash apply";
      ss = "stash save";
    };
  };
}