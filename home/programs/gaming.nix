{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    steam
    steam-run
    mangohud
    gamemode
    protonup-qt
    gamescope
    itgmania
  ];
}