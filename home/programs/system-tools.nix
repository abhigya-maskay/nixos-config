{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pciutils
    usbutils
    gptfdisk
    unixtools.fdisk
    kdePackages.partitionmanager
    # Joystick configuration tools
    linuxConsoleTools  # jstest, jscal for dead zone adjustment
  ];
}
