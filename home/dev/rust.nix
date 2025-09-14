{ config, pkgs, ... }:
{
  # Rust toolchain and tooling via nixpkgs
  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
  ];
}

