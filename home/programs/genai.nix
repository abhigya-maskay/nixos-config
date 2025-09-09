{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.nix-ai-tools.packages.${pkgs.system}.claude-code
    inputs.nix-ai-tools.packages.${pkgs.system}.codex
  ];
}
