{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
  };

  home.shellAliases.zed = "zeditor";
}
