# wofi.nix - Place this in your home-manager modules directory
{ config, lib, pkgs, ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      mode = "drun";
      show = "drun";

      width = 800;
      height = 500;
      location = "center";
      no_actions = false;
      prompt = "Search";

      allow_markup = true;
      allow_images = true;
      image_size = 32;
      term = "ghostty";

      insensitive = true;
      hide_scroll = true;

      columns = 3;
      lines = 7;

      layer = "overlay";
      sort_order = "alphabetical";
      gtk_dark = true;
      filter_rate = 100;
    };

    style = builtins.readFile ./style.css;
  };
}
