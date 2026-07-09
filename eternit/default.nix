# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules
  ];

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/844218ed-44c8-40c9-9c53-bff401acfae9";
      discardPolicy = "once";
      priority = 0;
    }
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  networking.hostName = "eternit";
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];
  xdg.portal.enable = true;

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

  system.stateVersion = "26.05"; # nie masz po co tego ruszac

}
