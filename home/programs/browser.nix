{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    vivaldi
    google-chrome
  ];
}
