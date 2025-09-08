{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.claude-code.packages.${pkgs.system}.default
    nodePackages.nodejs
    (pkgs.writeShellScriptBin "coder" ''
      exec ${pkgs.nodePackages.nodejs}/bin/npx @just-every/code "$@"
    '')
  ];
}
