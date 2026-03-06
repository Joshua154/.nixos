{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    bspwm
    sxhkd
    polybar
    dunst
    rofi
    feh
    picom
  ];
}
