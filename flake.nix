{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    vscode-server.url = "github:msteen/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    { self, nixpkgs, vscode-server, home-manager, impermanence, ... }@args: {
      nixosConfigurations.koma = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit vscode-server impermanence; };
        modules = [
          vscode-server.nixosModule
          impermanence.nixosModule
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };
    };
}
