{
  description = "Zinth's Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs: let
    inherit ( self ) outputs;

    forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    forEachPkgs = f: forEachSystem ( sys: f nixpkgs.legacyPackages.${sys} );
  in {
    nixosModules = import ./modules/nixos;
    overlays = import ./overlays { inherit inputs outputs; };
    packages = forEachPkgs ( pkgs: import ./pkgs { inherit pkgs; } );
    devShells = forEachPkgs ( pkgs: import ./shell.nix { inherit pkgs; } );

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/nixos ];
      };
    };
  };
}
