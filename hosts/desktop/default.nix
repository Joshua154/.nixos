{
  config,
  hostname,
  inputs,
  pkgs,
  system,
  username,
  lib,
  ...
}: {
  imports = [
    ../../modules/system/shared.nix
    ../../modules/system/syncthing.nix

    ./hardware-configuration.nix

    ../../modules/profiles/hardware/intel.nix
    ../../modules/profiles/hardware/nvidia.nix

    # Display Manager
    # ../../modules/profiles/display-managers/ly.nix
    ../../modules/profiles/display-managers/gdm.nix
    # ../../modules/profiles/display-managers/sddm.nix

    # Window Manager
    # ../../modules/profiles/window-managers/hyprland.nix
    # ../../modules/profiles/window-managers/bspwm.nix
    ../../modules/profiles/window-managers/gnome.nix
  ];

  networking.hostName = hostname;

  # environment.systemPackages = [
  #   pkgs.sbctl
  # ];

  # boot = {
  #   lanzaboote = {
  #     enable = true;
  #     pkiBundle = "/etc/secureboot";
  #   };
  # };

  # services.tlp.enable = true;
  powerManagement.enable = true;

  system.stateVersion = "25.05";
}
