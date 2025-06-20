{ config, pkgs, inputs, ... }:
{
  # Enable Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;

  # If you are using GDM as your login manager
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true; # Keep GNOME enabled for now

  # It's good practice to also enable the xdg-desktop-portal-hyprland
#  xdg.portal = {
#    enable = true;
#    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
#  };
}
