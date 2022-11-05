{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    vscode-server.url = "github:msteen/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, vscode-server, home-manager, ... }@args: {
    nixosConfigurations.koma = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { vscode-server = vscode-server; };
      modules = [
        vscode-server.nixosModule
        home-manager.nixosModules.home-manager
        ./configuration.nix
      ];
    };
  };
}
