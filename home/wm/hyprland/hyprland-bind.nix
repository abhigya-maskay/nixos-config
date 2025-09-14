{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.bind = [
    # General
    "$mod, return, exec, $terminal"
    "$mod SHIFT, Q, killactive"
    "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"

    # Screen focus
    "$mod, f, togglefloating"
    "$mod, SHIFT f, fullscreen"
    "$mod, p, pin, active"

    # Screen resize
    "$mod CTRL, h, resizeactive, -20 0"
    "$mod CTRL, l, resizeactive, 20 0"
    "$mod CTRL, k, resizeactive, 0 -20"
    "$mod CTRL, j, resizeactive, 0 20"

    # Workspaces
    "$mod, 1, workspace, 1"
    "$mod, 2, workspace, 2"
    "$mod, 3, workspace, 3"
    "$mod, 4, workspace, 4"
    "$mod, 5, workspace, 5"
    "$mod, 6, workspace, 6"
    "$mod, 7, workspace, 7"
    "$mod, 8, workspace, 8"
    "$mod, 9, workspace, 9"
    "$mod, 0, workspace, 10"

    # Move to workspaces
    "$mod SHIFT, 1, movetoworkspace, 1"
    "$mod SHIFT, 2, movetoworkspace, 2"
    "$mod SHIFT, 3, movetoworkspace, 3"
    "$mod SHIFT, 4, movetoworkspace, 4"
    "$mod SHIFT, 5, movetoworkspace, 5"
    "$mod SHIFT, 6, movetoworkspace, 6"
    "$mod SHIFT, 7, movetoworkspace, 7"
    "$mod SHIFT, 8, movetoworkspace, 8"
    "$mod SHIFT, 9, movetoworkspace, 9"
    "$mod SHIFT, 0, movetoworkspace, 10"

    # Navigation
    "$mod, h, movefocus, l"
    "$mod, l, movefocus, r"
    "$mod, k, movefocus, u"
    "$mod, j, movefocus, d"

    # Applications
    "$mod, e, exec, ${pkgs.yazi}/bin/yazi"
    "$mod, d, exec, ${pkgs.wofi}/bin/wofi"
  ];
}
