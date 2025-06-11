{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    iftop
  ];
}
