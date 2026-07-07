# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/844218ed-44c8-40c9-9c53-bff401acfae9";
      discardPolicy = "once";
      priority = 0;
    }
  ];

  fileSystems."/".options = [
    "noatime"
    "compress=zstd:3"
  ];
  fileSystems."/home".options = [
    "subvol=home"
    "noatime"
    "compress=zstd:3"
  ];
  fileSystems."/nix".options = [
    "x-initrd.mount"
    "subvol=nix"
    "noatime"
    "compress=zstd:3"
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  # intel-ucode
  hardware.enableRedistributableFirmware = true;

  # cachy-kernel
  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-x86_64-v3;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "pl_PL.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];
  xdg.portal.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."szymon" = {
    isNormalUser = true;
    description = "szymon";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;

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
  ];

  programs.nix-ld.enable = true;

  #nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  system.stateVersion = "26.05"; # nie masz po co tego ruszac

}
