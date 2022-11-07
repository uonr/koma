{ pkgs, vscode-server, ... }: {
  imports = [ ./users/root.nix ./users/mikan.nix ];
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  users.mutableUsers = false;
}
