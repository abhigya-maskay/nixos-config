{ config, pkgs, inputs, ... }:

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
    zlib
    zlib.dev
    inputs.nix-ai-tools.packages.${pkgs.system}.gemini-cli
  ];
}
