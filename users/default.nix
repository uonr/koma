{ pkgs, vscode-server, ... }: {
  imports = [ ./root.nix ./mikan.nix ];
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ vscode-server.nixosModules.home ./home ];
  };
  users.mutableUsers = false;
}
