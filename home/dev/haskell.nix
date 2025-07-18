{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    cabal-install
    haskellPackages.cabal-gild
    ghc
    ormolu
    (haskell-language-server.override {
        supportedGhcVersions = ["910" "984"];
    })
    haskellPackages.hoogle
    haskellPackages.hie-bios
    haskellPackages.implicit-hie
    stack
  ];
}
