{ config, pkgs, ... }:

{
  systemd.user.services.talon = {
    Unit = {
      Description = "Talon Voice";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.steam-run}/bin/steam-run ${config.home.homeDirectory}/.local/share/talon/talon";
      Restart = "on-failure";
      RestartSec = 5;
      Environment = "QT_XCB_GL_INTEGRATION=none";
      NoNewPrivileges = false;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
