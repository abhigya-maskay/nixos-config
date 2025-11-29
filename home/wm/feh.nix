{ pkgs, lib, inputs, ... }:
let
  wallpaperScript = pkgs.writeShellScriptBin "feh-wallpaper-rotate" ''
    set -euo pipefail

    WALLPAPER_DIR=${lib.escapeShellArg "${inputs.catppuccin-wallpapers}"}

    while true; do
      WALLPAPER=$(${pkgs.findutils}/bin/find "$WALLPAPER_DIR" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | ${pkgs.coreutils}/bin/shuf -n 1)
      if [ -z "$WALLPAPER" ]; then
        exit 0
      fi
      ${pkgs.feh}/bin/feh --bg-fill "$WALLPAPER"
      ${pkgs.coreutils}/bin/sleep 120
    done
  '';
in
{
  home.packages = [
    pkgs.feh
    wallpaperScript
  ];

  systemd.user.services.wallpaper-rotate = {
    Unit = {
      Description = "Rotate Catppuccin wallpapers";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${wallpaperScript}/bin/feh-wallpaper-rotate";
      Restart = "always";
      RestartSec = 5;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
