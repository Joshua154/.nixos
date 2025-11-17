{ config, pkgs, ... }:

let
  theme = "Balcony";
in
{
  home.packages = with pkgs; [
    hyprlock
    hypridle
    fuzzel
    swww
  ];

  imports = [
    ./${theme}
  ]
}
