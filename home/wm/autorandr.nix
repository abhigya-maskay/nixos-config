{ pkgs, ... }:

{
  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "notify" = "${pkgs.libnotify}/bin/notify-send 'Display profile switched'";
        "reload-bspwm" = "${pkgs.bspwm}/bin/bspc wm -r";
        "reload-polybar" = "systemctl --user restart polybar";
      };
    };
  };
}
