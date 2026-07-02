{
  description = "Flaken";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    # Add the Helium browser flake
    helium.url = "github:oxcl/nix-flake-helium-browser";
    helium.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, helium, ... }@inputs: {
   nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
     modules = [
       ./configuration.nix
       ({ pkgs, ... }: {
         # Add both the CachyOS and Helium overlays
         nixpkgs.overlays = [
           nix-cachyos-kernel.overlays.pinned
           helium.overlays.default
         ];
       })
     ];
   };
  };
}
