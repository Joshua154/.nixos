{ config, pkgs, ... }:

let
  theme = "theme";
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
