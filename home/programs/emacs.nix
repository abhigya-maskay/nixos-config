{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  services.emacs = {
    enable = true;
    startWithUserSession = true;
  };

  home.shellAliases = {
    e = "emacsclient --create-frame";
    et = "emacsclient --create-frame --tty";
  };
}
