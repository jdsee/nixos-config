{
  description = "My personal system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay } @inputs:
    let
      user = "jdsee";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user;
        }
      );
    };
}
