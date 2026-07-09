{
  description = "Flaken";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    helium.url = "github:oxcl/nix-flake-helium-browser";
    helium.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      nix-cachyos-kernel,
      helium,
      ...
    }:
    {
      nixosConfigurations = {
        kokot = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./kokot
            ({ ... }: {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
                helium.overlays.default
                # (import ./overlays/plasma-workspace.nix)
              ];
            })
          ];
        };
      };
    };
}
