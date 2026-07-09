{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  hardware.enableRedistributableFirmware = true;

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
}
