{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pciutils
    usbutils
    gptfdisk
    unixtools.fdisk
  ];
}
