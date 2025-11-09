{ config, pkgs, doomemacs, doom-config, ... }:

{
  home.username = "ave70011";
  home.homeDirectory = "/home/ave70011";

  programs.git = {
    enable = true;
    userName = "Abhigya Maskay";
    userEmail = "ave70011@gmail.com";
  };

  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  imports = [
    ./programs
    ./dev
    ./wm
    ./joystick.nix
  ];

  home.stateVersion = "25.05";
}
