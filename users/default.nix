{ pkgs, vscode-server, ... }: {
  imports = [ ./root.nix ./mikan.nix ];
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  users.mutableUsers = false;
}
