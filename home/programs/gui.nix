{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.dolphin
    obsidian
    pavucontrol
    libsForQt5.qt5.qtwayland
    xclip
    maim
    slop  # for selecting screen region with maim
    vial
    (callPackage ../../packages/antigravity.nix {})
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "xcb";
  };
}
