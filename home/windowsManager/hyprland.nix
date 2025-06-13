{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;

  programs.waybar.enable = true; 
  services.gnome-keyring.enable = true; 

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}

