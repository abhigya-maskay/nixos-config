{ config, pkgs, doomemacs, doom-config, ... }:

{
  home.username = "ave70011";
  home.homeDirectory = "/home/ave70011";

  programs.git = {
    enable = true;
    settings = {
      user.name = "Abhigya Maskay";
      user.email = "ave70011@gmail.com";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      gemini = "npx -y @google/gemini-cli@preview";
    };
  };

  imports = [
    ./programs
    ./dev
    ./wm
    ./joystick.nix
    ./talon.nix
  ];

  home.stateVersion = "25.05";
}
