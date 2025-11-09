{ config, pkgs, ... }:

{
  # Systemd user service to calibrate VKB joystick on login
  systemd.user.services.joystick-calibration = {
    Unit = {
      Description = "Calibrate VKB Gladiator EVO R (reduce dead zone to near zero)";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";  # Wait for device to be ready
      # Calibration string for VKB Gladiator EVO R with minimal dead zones
      # Setting dead zone values to 5-10 for near-zero dead zone response
      ExecStart = "${pkgs.linuxConsoleTools}/bin/jscal -s 10,1,5,1792,2302,349297,349297,1,5,1792,2302,349297,349297,1,5,896,1150,698141,698141,1,5,1792,2302,349297,349297,1,5,1792,2302,349297,349297,1,5,896,1150,698141,698141,1,5,896,1150,698141,698141,1,5,896,1150,698141,698141,1,0,0,0,536870912,536870912,1,0,0,0,536870912,536870912 /dev/input/js1";
      RemainAfterExit = true;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
