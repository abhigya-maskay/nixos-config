{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    swww
    (pkgs.writeShellScriptBin "wallpaper-rotate" ''
      WALLPAPER_DIR="${inputs.catppuccin-wallpapers}"

      while true; do
        WALLPAPER=$(find "$WALLPAPER_DIR" -name "*.png" -o -name "*.jpg" | shuf -n 1)
        ${pkgs.swww}/bin/swww img "$WALLPAPER" --transition-type fade
        sleep 600 #
      done
    '')
  ];
}
