{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    python313
    python313Packages.black
    python313Packages.pyflakes
    python313Packages.isort
    python313Packages.pytest
    python313Packages.setuptools
    pipenv
  ];
}
