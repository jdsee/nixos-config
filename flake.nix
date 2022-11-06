{
  description = "My personal system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, home-manager }: 
  let
    user = "jdsee";
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      "${user}" = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user inputs; };
        modules = [
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit user; };
              users.${user} = {
                imports = [ ./home ];
              };
            };
          }
        ];
      };
    };
  };
}
