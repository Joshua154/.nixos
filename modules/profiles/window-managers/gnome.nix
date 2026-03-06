{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  
  services.displayManager.gdm = {
    enable = lib.mkDefault true;
    wayland = true;
  };

  # Exclude default GNOME applications
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany # web browser
    geary # email client
  ];
}
