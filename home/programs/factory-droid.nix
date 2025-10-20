{ pkgs, lib, ... }:

# Factory droid CLI requires a FHS environment to run dynamically linked binaries
let
  # FHS environment for running the droid binary
  droidFHS = pkgs.buildFHSEnv {
    name = "droid-fhs";
    targetPkgs = pkgs: with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      curl
      ripgrep
      coreutils
    ];
    profile = ''
      export TMPDIR="''${TMPDIR:-$HOME/.cache/factory-tmp}"
      mkdir -p "$TMPDIR"
    '';
    runScript = "${pkgs.writeShellScript "droid-runner" ''
      exec "$HOME/.local/bin/droid" "$@"
    ''}";
  };
in
# Wrapper that installs droid on first run, then delegates to FHS environment
pkgs.writeShellScriptBin "droid" ''
  set -euo pipefail

  INSTALL_URL="https://app.factory.ai/cli"
  LOCAL_BIN="$HOME/.local/bin"
  LOCAL_DROID="$LOCAL_BIN/droid"
  FACTORY_BIN_DIR="$HOME/.factory/bin"

  # Provide ripgrep from Nix to avoid installer conflicts
  mkdir -p "$FACTORY_BIN_DIR"
  if [ ! -e "$FACTORY_BIN_DIR/rg" ]; then
    ln -sf "${pkgs.ripgrep}/bin/rg" "$FACTORY_BIN_DIR/rg"
  fi

  # Install droid CLI if not present
  if [ ! -x "$LOCAL_DROID" ]; then
    mkdir -p "$LOCAL_BIN"
    # Download and run installer with PATH set to prevent it from trying to install rg
    PATH="$FACTORY_BIN_DIR:$PATH" "${pkgs.bash}/bin/sh" -c "$(${pkgs.curl}/bin/curl -fsSL $INSTALL_URL)"
  fi

  # Run droid in FHS environment
  exec "${droidFHS}/bin/droid-fhs" "$@"
''
