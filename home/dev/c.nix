{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    libtool
    gcc
  ];
}
