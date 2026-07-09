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
      device = "/dev/disk/by-uuid/8fb81654-c045-4a56-86cf-2acd1ed0dcb2";
      discardPolicy = "once";
      priority = 0;
    }
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  networking.hostName = "kokot";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

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

  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  system.stateVersion = "26.05";

}
