{ pkgs, ... }:
{
  xdg.configFile."hypr" = {
    source = ./hypr;
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = ./waybar;
    recursive = true;
  };

  home.packages = with pkgs; [
    waybar-hyprland
    rofi
    dunst
    kitty
    swaybg
    swaylock-effects
    swayidle
    pamixer
    light
    brillo
    canva
  ];
}