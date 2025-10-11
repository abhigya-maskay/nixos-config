{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    cabal-install
    haskellPackages.cabal-gild
    ghc
    ormolu
    haskell-language-server
    haskellPackages.hoogle
    haskellPackages.hie-bios
    haskellPackages.implicit-hie
    haskellPackages.zlib
    stack
  ];
}
