{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./cachy.nix
    ./locales.nix
    ./nvidia.nix
    ./pipewire.nix
    ./pkgs.nix
    ./steam.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

}
