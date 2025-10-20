{ config, pkgs, lib, ... }:
{
  home.packages = [
    pkgs.ghostty
    pkgs.warp-terminal
  ];
  programs.ghostty = {
    settings = {
      background-opacity = 0.8;
      background-blur-radius = 20;
    };
  };

  catppuccin = {
    ghostty = {
      enable = true;
      flavor = "mocha";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.importTOML "${pkgs.starship}/share/starship/presets/catppuccin-powerline.toml";
  };
}
