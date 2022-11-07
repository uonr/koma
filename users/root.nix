{ pkgs, vscode-server, ... }:
let sshKey = builtins.readFile ./id-rsa.pub;
in {
  users.users.root = {
    hashedPassword = "!";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ sshKey ];
  };
  home-manager.users.root = { ... }: {
    imports = [ vscode-server.nixosModules.home ./home/basic.nix ];
  };
}
