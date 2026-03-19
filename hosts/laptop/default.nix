# Example configuration for a second host (laptop)
{ config, hostname, inputs, pkgs, system, username, ... }:

{
  imports = [
    ../../modules/system/shared.nix

    ./hardware-configuration.nix

    ../../modules/profiles/hardware/intel.nix

    # Display Manager
    # ../../modules/profiles/display-managers/ly.nix
    ../../modules/profiles/display-managers/gdm.nix
    # ../../modules/profiles/display-managers/sddm.nix

    # Window Manager
    # ../../modules/profiles/window-managers/hyprland.nix
    # ../../modules/profiles/window-managers/bspwm.nix
    ../../modules/profiles/window-managers/gnome.nix
    # ../../modules/profiles/window-managers/qtile.nix
  ];

  networking.hostName = hostname;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # services.tlp.enable = true;
  powerManagement.enable = true;

  system.stateVersion = "25.05";
}
