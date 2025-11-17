{ pkgs, ... }:

let
  dirs = [ "cava" "dunst" "hypr" "kitty" "rofi" "waybar" ];
in
{
  xdg.configFile = builtins.listToAttrs (map (name: {
    name = name;
    value = {
      source = ./${name};
      recursive = true;
    };
  }) dirs);

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
