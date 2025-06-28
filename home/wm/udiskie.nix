{ pkgs, ... }:
{
  services.usdiskie = {
    enable = true;
    tray = "always";
    notify = true;
    automount = true;
  };
}
