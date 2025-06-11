{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    cabal-install
    ghc
    ormolu
    haskell-language-server
    haskellPackages.hoogle
    stack
  ];
}
