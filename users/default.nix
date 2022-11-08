{ pkgs, ... }: {
  imports = [ ./root.nix ./mikan.nix ];
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
  users.mutableUsers = false;
}
