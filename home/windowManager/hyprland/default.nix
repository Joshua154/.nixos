{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock
    hypridle
    fuzzel
    swww
  ];

  xdg.configFile."hypr" = {
    source = ./config/hypr;
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = ./config/waybar;
    recursive = true;
  };
}
