{ config, pkgs, lib, ... }:
{
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  environment.systemPackages = with pkgs; [
    zoom-us
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];
}