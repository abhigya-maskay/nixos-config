{config, pkgs, lib, inputs, ...}:
{
  home.packages = [
    inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  programs.ghostty = {
    settings = {
      background-opacity = 0.8;
      background-blur-radius = 20;
    };
  };

  catppuccin = {
    ghostty = {
      enable = true;
      flavor = "mocha";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.importTOML "${pkgs.starship}/share/starship/presets/catppuccin-powerline.toml";
  };
}
