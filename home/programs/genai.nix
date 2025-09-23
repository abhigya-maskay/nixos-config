{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.nix-ai-tools.packages.${pkgs.system}.claude-code
    inputs.nix-ai-tools.packages.${pkgs.system}.codex
    (pkgs.writeShellScriptBin "context7-mcp" ''
      exec ${pkgs.nodejs}/bin/npx -y @upstash/context7-mcp "$@"
    '')
  ];
}
