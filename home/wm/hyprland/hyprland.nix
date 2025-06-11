{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    swappy
    hyprpolkitagent
    hyprland-qtutils
    hyprcursor
    hyprlock
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = ["--all"];
    };
    xwayland = {
      enable = true;
    };
    settings = {
      "$terminal" = "ghostty";
      "$mod" = "SUPER";
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user start hyprpolkitagent"
        "waybar"
        "swww init"
        "wallpaper-rotate"
      ];

      general = {
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
        resize_on_border = true;
        "col.active_border" = "$mauve $pink 45deg";
        "col.inactive_border" = "$surface0";
      };

      input = {
        follow_mouse = true;
        touchpad = {
          natural_scroll = true;
        };
        accel_profile = "flat";
        sensitivity = 0;
      };

      decoration = {
        rounding = 15;
        blur = {
          enabled = true;
          xray = true;
          special = false;
          size = 14;
          passes = 4;
          noise = 0.01;
          contrast = 0.9;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = true;
          render_power = 3;
          color = "$base";
        };
      };

      windowrulev2 = [
        "opacity 0.75 0.75,class:^(com.mitchellh.ghostty)$"
        "opacity 0.75 0.75,class:^(emacs)$"
        "opacity 0.8 0.8,class:^(Vivaldi-stable)$"
      ];

      cursor = {
        enable_hyprcursor = true;
      };

    };
  };

  catppuccin.hyprland.enable = true;
}
