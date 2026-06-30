{
  config,
  pkgs,
  libs,
  ...
}: {
  imports = [
    # ./hyprland
    ./gnome

    #./bspwm
  ];
}
