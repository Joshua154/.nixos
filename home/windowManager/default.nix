{
  host,
  lib,
  ...
}: let
  available = {
    bspwm = ./bspwm;
    gnome = ./gnome;
    hyprland = ./hyprland;
  };
  selected = host.profiles.desktops;
  unknown = builtins.filter (name: !(builtins.hasAttr name available)) selected;
in {
  assertions = [
    {
      assertion = unknown == [];
      message = "Unknown Home Manager desktop profile(s): ${lib.concatStringsSep ", " unknown}";
    }
  ];

  imports = map (name: available.${name}) selected;
}
