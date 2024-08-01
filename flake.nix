{
  description = "Open source, compact, and material designed cursor set.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    systems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    nixpkgsFor = systems (system: import nixpkgs { inherit system; });
  in {
    packages = systems (system:
    let
      pkgs = nixpkgsFor.${system}.pkgs;
      mkCursor = import ./lib/mkCursor.nix { inherit pkgs fetchTarball; };
      version = "2.0.7";
    in {
      bibata-modern-classic = pkgs.callPackage ./Bibata-Modern-Classic.nix { inherit mkCursor version; };
      bibata-modern-ice = pkgs.callPackage ./Bibata-Modern-Ice.nix { inherit mkCursor version; };
    });

    defaultPackage = systems (system: self.packages.${system}.bibata-modern-classic);
  };
}
