{ config, lib, pkgs, inputs, ... }:

let
  factoryDroid = pkgs.callPackage ./factory-droid.nix {};
in
{
  home.packages = [
    factoryDroid
    (pkgs.writeShellScriptBin "claude" ''
      exec ${pkgs.nodejs}/bin/npx -y @anthropic-ai/claude-code "$@"
    '')
    inputs.nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.claude-code-router
    inputs.nix-ai-tools.packages.${pkgs.stdenv.hostPlatform.system}.codex
    (pkgs.writeShellScriptBin "context7-mcp" ''
      exec ${pkgs.nodejs}/bin/npx -y @upstash/context7-mcp "$@"
    '')
    (pkgs.writeShellScriptBin "glm" ''
      secret_file=/etc/nixos/secrets/anthropic.env
      if [ -z ''${ANTHROPIC_AUTH_TOKEN:-} ] && [ -r "$secret_file" ]; then
        # shellcheck disable=SC1090 -- sourcing user-managed secret file
        . "$secret_file"
      fi
      if [ -z ''${ANTHROPIC_AUTH_TOKEN:-} ]; then
        echo "ANTHROPIC_AUTH_TOKEN not set; add it to $secret_file" >&2
        exit 1
      fi
      export ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic
      export ANTHROPIC_AUTH_TOKEN="$ANTHROPIC_AUTH_TOKEN"
      export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.6"
      export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
      exec ${pkgs.nodejs}/bin/npx -y @anthropic-ai/claude-code "$@"
    '')
  ];
}
