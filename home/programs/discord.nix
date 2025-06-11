{pkgs, ...}:
{
  home.packages = with pkgs; [
    vesktop
  ];

  xdg.configFile."vesktop/themes/catppuccin-mocha.css".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/discord/main/themes/mocha.theme.css";
    sha256 = "1w921c6zg5xvkf52x642psnqpaannbd28cc37dfzasbplw7ghl2x";
  };

  xdg.configFile."vesktop/settings/settings.json".text = builtins.toJSON {
    discordBranch = "stable";
    minimizeToTray = true;
    arRPC = true;
    vencord = {
      themes = [ "catppuccin-mocha.css" ];
      enabledThemes = [ "catppuccin-mocha.css" ];
    };
  };
}
