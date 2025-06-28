{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    cabal-install
    haskellPackages.cabal-gild
    ghc
    ormolu
    haskell-language-server
    haskellPackages.hoogle
    stack
  ];
}
