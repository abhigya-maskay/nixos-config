{ config, pkgs, lib, ... }:
let
  modKey = "super";
  terminalCmd = "ghostty";
  launcherCmd = "${pkgs.dmenu}/bin/dmenu_run -i -p 'Search'";
  workspaces = (builtins.map builtins.toString (lib.range 1 9)) ++ [ "0" ];
  toDesktop = n: if n == "0" then "10" else n;
  fileManagerCmd = "${terminalCmd} -e ${lib.getExe pkgs.yazi}";
  workspaceNames = builtins.map (n: toDesktop n) workspaces;
  workspaceList = lib.concatStringsSep " " workspaceNames;
  workspaceBindings =
    lib.listToAttrs (builtins.map (n: {
      name = "${modKey} + ${n}";
      value = "bspc desktop -f ${toDesktop n}";
    }) workspaces);
  moveBindings =
    lib.listToAttrs (builtins.map (n: {
      name = "${modKey} + shift + ${n}";
      value = "bspc node -d ${toDesktop n}";
    }) workspaces);
in
{
  home.packages = with pkgs; [
    dmenu
  ];

  xsession = {
    enable = true;
    scriptPath = ".xinitrc";
    windowManager.bspwm = {
      enable = true;
      settings = {
        border_width = 2;
        window_gap = 8;
        split_ratio = 0.52;
        focus_follows_pointer = true;
        pointer_follows_monitor = true;
      };
      startupPrograms = [
        "sxhkd"
      ];
      extraConfig = ''
        ${pkgs.xorg.xset}/bin/xset s off -dpms

        for monitor in $(bspc query -M); do
          bspc monitor "$monitor" -d ${workspaceList}
        done

        bspc config focused_border_color "#f5c2e7"
        bspc config normal_border_color "#313244"
        bspc config active_border_color "#b4befe"
        bspc rule -a Emacs state=tiled
        bspc rule -a steam state=floating follow=on
        bspc rule -a steam_app_.* state=tiled follow=on
        bspc rule -a pobfrontend state=tiled follow=on
      '';
    };
  };

  services.sxhkd = {
    enable = true;
    keybindings =
      let
        toggleFloating = ''
          if bspc query -N -n focused.floating > /dev/null; then
            bspc node -t tiled
          else
            bspc node -t floating
          fi
        '';
        toggleFullscreen = ''
          if bspc query -N -n focused.fullscreen > /dev/null; then
            bspc node -t tiled
          else
            bspc node -t fullscreen
          fi
        '';
      in
      {
        "${modKey} + Return" = terminalCmd;
        "${modKey} + shift + q" = "bspc node -c";
        "${modKey} + shift + x" = "loginctl lock-session";

        "${modKey} + f" = toggleFloating;
        "${modKey} + shift + f" = toggleFullscreen;
        "${modKey} + p" = "bspc node -g sticky";

        "${modKey} + ctrl + h" = "bspc node -z left -20 0";
        "${modKey} + ctrl + l" = "bspc node -z right +20 0";
        "${modKey} + ctrl + k" = "bspc node -z up 0 -20";
        "${modKey} + ctrl + j" = "bspc node -z down 0 +20";

        "${modKey} + h" = "bspc node -f west";
        "${modKey} + l" = "bspc node -f east";
        "${modKey} + k" = "bspc node -f north";
        "${modKey} + j" = "bspc node -f south";

        "${modKey} + shift + h" = "bspc node -s west";
        "${modKey} + shift + l" = "bspc node -s east";
        "${modKey} + shift + k" = "bspc node -s north";
        "${modKey} + shift + j" = "bspc node -s south";

        "${modKey} + e" = fileManagerCmd;
        "${modKey} + d" = launcherCmd;
        "${modKey} + shift + s" = "maim -s | xclip -selection clipboard -t image/png";
        "${modKey} + shift + m" = "autorandr --change";
      }
      // workspaceBindings
      // moveBindings;
  };

}
