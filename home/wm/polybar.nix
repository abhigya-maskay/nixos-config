{ pkgs, lib, ... }:
{
  # SNI (StatusNotifierItem) to XEmbed proxy for system tray
  home.packages = with pkgs; [
    snixembed
  ];

  systemd.user.services.snixembed = {
    Unit = {
      Description = "SNI XEmbed Proxy";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.snixembed}/bin/snixembed";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar;
    script = ''
      polybar-msg cmd quit >/dev/null 2>&1 || true

      # Get the primary monitor (first in the list)
      PRIMARY=$(polybar --list-monitors | ${pkgs.coreutils}/bin/head -n1 | ${pkgs.coreutils}/bin/cut -d: -f1)

      for monitor in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d: -f1); do
        if [ "$monitor" = "$PRIMARY" ]; then
          MONITOR="$monitor" TRAY_POSITION=right polybar main &
        else
          MONITOR="$monitor" TRAY_POSITION=none polybar main &
        fi
      done

      wait
    '';
    config = {

      "bar/main" = {
        monitor = "\${env:MONITOR:}";
        width = "100%";
        height = "34";
        background = "\${colors.base}";
        foreground = "\${colors.text}";
        line-size = "0";
        border-size = "0";
        padding-left = "12";
        padding-right = "2";
        module-margin = "0";
        separator = "";
        font-0 = "Monaspace Radon Frozen:style=Regular:size=12;2";
        font-1 = "Monaspace Radon Frozen:style=Bold:size=12;2";
        font-2 = "Font Awesome 7 Free:style=Solid:size=12;2";
        font-3 = "Font Awesome 7 Brands:style=Regular:size=12;2";
        modules-left = "xwindow";
        modules-center = "bspwm";
        modules-right = "pulseaudio network cpu memory temperature keyboard clock";
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
        tray-position = "\${env:TRAY_POSITION:none}";
        tray-padding = "2";
        tray-background = "\${colors.base}";
        tray-maxsize = 24;
        tray-detached = false;
        enable-ipc = true;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        format = "<label>";
        format-prefix = "➡  ";
        format-prefix-foreground = "\${colors.peach}";
        label = "%title%";
        label-empty = "Desktop";
        label-maxlen = 60;
        label-foreground = "\${colors.text}";
        label-padding = 4;
      };

      "module/bspwm" = {
        type = "internal/bspwm";
        pin-workspaces = true;
        enable-click = true;
        enable-scroll = true;
        reverse-scroll = false;
        format = "<label-state>";
        label-focused = "%icon%";
        label-focused-padding = 3;
        label-focused-background = "\${colors.surface0}";
        label-focused-foreground = "\${colors.peach}";
        label-occupied = "%icon%";
        label-occupied-padding = 3;
        label-occupied-foreground = "\${colors.subtext1}";
        label-empty = "%icon%";
        label-empty-padding = 3;
        label-empty-foreground = "\${colors.overlay0}";
        ws-icon-0 = "1;";
        ws-icon-1 = "2;";
        ws-icon-2 = "3;";
        ws-icon-3 = "4;";
        ws-icon-4 = "5;";
        ws-icon-default = "";
        format-background = "\${colors.base}";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        interval = 2;
        use-ui-max = true;
        format-volume = "<label-volume>";
        format-volume-prefix = " ";
        format-volume-padding = 2;
        format-volume-background = "\${colors.surface0}";
        format-volume-prefix-background = "\${colors.surface0}";
        format-volume-foreground = "\${colors.pink}";
        label-volume = "<ramp-volume>  %percentage%%";
        label-muted = "";
        format-muted = "<label-muted>";
        format-muted-prefix = " ";
        format-muted-padding = 2;
        format-muted-background = "\${colors.surface0}";
        format-muted-prefix-background = "\${colors.surface0}";
        label-muted-foreground = "\${colors.overlay1}";
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        ramp-volume-foreground = "\${colors.pink}";
        click-left = "pavucontrol";
      };

      "module/network" = {
        type = "custom/script";
        exec = "~/.config/polybar/scripts/network-state.sh";
        interval = 5;
        format = "<label>";
        format-padding = 2;
        format-background = "\${colors.surface0}";
        format-foreground = "\${colors.peach}";
        click-left = "ghostty -e nmtui";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format = "<label>";
        format-padding = 2;
        format-background = "\${colors.surface0}";
        format-foreground = "\${colors.peach}";
        label = " %percentage%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 5;
        format = "<label>";
        format-padding = 2;
        format-background = "\${colors.surface0}";
        format-foreground = "\${colors.yellow}";
        label = "%percentage_used%% ";
      };

      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;
        interval = 5;
        format = "<ramp> <label>";
        format-padding = 2;
        format-background = "\${colors.surface0}";
        format-foreground = "\${colors.green}";
        label = "%temperature-c%°C";
        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
        warn-temperature = 80;
        format-warn = "<ramp> <label-warn>";
        format-warn-padding = 2;
        format-warn-background = "\${colors.surface0}";
        label-warn = "%temperature-c%°C";
        label-warn-foreground = "\${colors.red}";
      };

      "module/keyboard" = {
        type = "internal/xkeyboard";
        blacklist-0 = "scroll lock";
        format = "<label-indicator>";
        format-padding = 2;
        format-background = "\${colors.surface0}";
        format-foreground = "\${colors.mauve}";
        indicator-icon-default = "";
        indicator-icon-0 = "caps lock;⇪";
        indicator-icon-1 = "num lock;⇭";
        indicator-on = "%icon%";
        indicator-off = "";
        indicator-separator = " ";
      };

      "module/clock" = {
        type = "internal/date";
        interval = 30;
        date = "%a %b %d";
        time = "%H:%M";
        format = "<label>";
        format-suffix = " ";
        format-padding = 2;
        format-background = "\${colors.surface0}";
        format-suffix-background = "\${colors.surface0}";
        format-foreground = "\${colors.sky}";
        label = "%date%  %time%";
      };
    };
  };

  home.file.".config/polybar/scripts/network-state.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      active_line=$(${pkgs.networkmanager}/bin/nmcli -t -f DEVICE,TYPE,STATE,CONNECTION device status \
        | ${pkgs.gawk}/bin/awk -F: '$3=="connected"{print; exit}')

      if [[ -z ''${active_line:-} ]]; then
        echo "⚠ Disconnected"
        exit 0
      fi

      IFS=":" read -r device dev_type _ connection <<< "$active_line"

      if [[ "$dev_type" == "wifi" ]]; then
        wifi_lines=$(${pkgs.networkmanager}/bin/nmcli -t -f DEVICE,SIGNAL device wifi 2>/dev/null || true)
        signal=$(${pkgs.gawk}/bin/awk -F: -v dev="$device" '$1==dev{print $2; exit}' <<< "$wifi_lines")
        signal=''${signal:-0}
        essid=${connection:-$device}
        echo " $essid ($signal%)"
      else
        ip=$(${pkgs.networkmanager}/bin/nmcli -g IP4.ADDRESS device show "$device" \
          | ${pkgs.coreutils}/bin/head -n1 | ${pkgs.coreutils}/bin/cut -d/ -f1)
        if [[ -z ''${ip:-} ]]; then
          ip=$(${pkgs.iproute2}/bin/ip -o -4 addr show "$device" | ${pkgs.gawk}/bin/awk '{print $4}' | ${pkgs.coreutils}/bin/head -n1)
        fi
        echo " $device ''${ip:-No IP}"
      fi
    '';
  };

  systemd.user.services.polybar.Service.Type = lib.mkForce "simple"; # avoid timeout when script waits for child bars
}
