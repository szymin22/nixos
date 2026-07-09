{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gh
    alsa-utils
    fastfetch
    helium
    equibop
    alacritty
    btop
    zed-editor
    nil
    nixd
    ncdu
    neovim
    aria2
    unrar
    rar
    zip
    unzip
    cider-2
  ];

}
