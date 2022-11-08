{ pkgs, ... }:
let sshKey = builtins.readFile ../keys/id-rsa.kiyomi.pub;
in {
  users.users.root = {
    hashedPassword = "!";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ sshKey ];
  };
  home-manager.users.root = { ... }: {
    home.my = {
      enable = true;
      development = true;
      gui = false;
      entertainment = false;
    };

    programs.git = {
      userEmail = "me@yuru.me";
      userName = "Tachibana Kiyomi";
    };
  };
}
