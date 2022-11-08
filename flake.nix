{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    vscode-server.url = "github:msteen/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    { self, nixpkgs, vscode-server, home-manager, impermanence, agenix, ... }: {
      nixosConfigurations.koma = let system = "x86_64-linux";
      in nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit vscode-server impermanence;
          agenix = agenix.defaultPackage.${system};
        };
        modules = [
          vscode-server.nixosModule
          agenix.nixosModule
          impermanence.nixosModule
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };
    };
}
