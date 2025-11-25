{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        geometry = "300x60-20+48";
        shrink = false;
        transparency = 10;
        padding = 16;
        horizontal_padding = 16;
        frame_width = 2;
        frame_color = "#f5c2e7";
        separator_color = "frame";
        font = "JetBrainsMono Nerd Font 10";
        line_height = 4;
        idle_threshold = 120;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = true;
        ignore_newline = false;
        stack_duplicates = true;
        show_indicators = true;
        icon_position = "left";
        max_icon_size = 64;
        sticky_history = true;
        history_length = 20;
        browser = "firefox";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 8;
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 3;
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 5;
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#f38ba8";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}
