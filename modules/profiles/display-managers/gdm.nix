{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
  };

  # Disable GNOME desktop if only using GDM as login manager
  services.desktopManager.gnome.enable = lib.mkDefault false;
}
