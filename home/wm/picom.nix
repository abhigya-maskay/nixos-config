{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    # Hyprland-like rounded corners
    settings = {
      corner-radius = 12;
      
      # GLX Performance
      glx-no-stencil = true;
      use-damage = true;

      # Bypass compositor for fullscreen windows (improves game performance)
      unredir-if-possible = true;

      # Blur
      blur = {
        method = "dual_kawase";
        strength = 6;
      };
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Steam'"
        "class_g = 'steam_app_*'"
        "class_g = 'steamwebhelper'"
      ];

      # Shadows
      shadow = true;
      shadow-radius = 12;
      shadow-opacity = 0.5;
      shadow-offset-x = -12;
      shadow-offset-y = -12;
      shadow-exclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
      
      # Fading
      fading = true;
      fade-in-step = 0.08;
      fade-out-step = 0.08;
      
      opacity-rule = [
        "90:class_g = 'Emacs'"
        "90:class_g = 'Antigravity'"
        "90:class_g = 'antigravity'"
      ];
      
      # Animations (requires a picom fork with animations, but standard config is safe)
      # If using standard picom, these might be ignored or cause warnings, 
      # but usually safe in 'settings'. 
      # Common Hyprland feel comes from fluid movement.
    };
  };
}
