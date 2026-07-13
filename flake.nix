{
  description = "Flaken";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    helium.url = "github:oxcl/nix-flake-helium-browser";
    helium.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-cachyos-kernel,
      helium,
      rust-overlay,
      ...
    }:
    let
      shOverlays = [
        nix-cachyos-kernel.overlays.pinned
        helium.overlays.default
        (import ./overlays/plasma-workspace.nix)
        rust-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations = {

        eternit = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./eternit
            ({ ... }: {
              nixpkgs.overlays = shOverlays;
            })
          ];
        };

        kokot = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./kokot
            ({ ... }: {
              nixpkgs.overlays = shOverlays;
            })
          ];
        };

      };
    };
}
