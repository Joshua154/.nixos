{
  host,
  lib,
  ...
}: let
  inherit (host) profiles;
  profile = directory: name: directory + "/${name}.nix";
in {
  imports =
    [
      ./system/shared.nix
      (profile ./profiles/boot profiles.boot)
      (profile ./profiles/display-managers profiles.displayManager)
    ]
    ++ map (profile ./profiles/hardware) profiles.hardware
    ++ map (profile ./profiles/networking) profiles.networking
    ++ map (profile ./profiles/window-managers) profiles.desktops
    ++ map (profile ./profiles/programs) profiles.programs
    ++ map (profile ./system) profiles.services;

  powerManagement.enable = lib.mkDefault true;
  programs.nix-ld.enable = lib.mkDefault (host.nixLd or false);
}
