{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.fuse.userAllowOther = true;


  services.mullvad-vpn = {
  enable = true;
  package = pkgs.mullvad-vpn;
  };

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
    gearlever
    protonplus
    p7zip
    rust-bin.stable.latest.default
    nodejs_24
    nodePackages."@samuel/nxapi"
  ];


}
