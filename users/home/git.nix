{ ... }: {
  programs.git = {
    enable = true;
    difftastic.enable = true;
    ignores = [ ".DS_Store" ];
    userEmail = "me@yuru.me";
    userName = "Tachibana Kiyomi";
    extraConfig = {
      init = { defaultBranch = "master"; };
      push = { autoSetupRemote = true; };
    };

    aliases = {
      a = "add .";
      ci = "commit -S";
      cia = "commit -S --amend";
      co = "checkout";
      st = "status";
      br = "branch";
      sw = "switch";
      re = "rebase -i HEAD~10";
      lg =
        "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };
}
