{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    bat
    yq-go
    eza
    fzf
    neofetch
    fd
    pandoc
    ripgrep
    btop
  ];
}
