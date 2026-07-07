{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
    inputs.helium.overlays.default
    (import ./plasma-workspace.nix)
  ];
}
