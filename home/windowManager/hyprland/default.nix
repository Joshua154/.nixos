{ config, pkgs, xdg, lib, ... }:
{
  wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, RETURN, exec, kitty"
          "$mod, Q, killactive,"
        ];
      };
    };
  
  
    home.packages = with pkgs; [
      kitty
      waybar
      wofi
      mako
    ];

#  programs.waybar.enable = true;
#  services.gnome-keyring.enable = true;
#
#  home.sessionVariables = {
#    NIXOS_OZONE_WL = "1";
#    WLR_NO_HARDWARE_CURSORS = "1";
#  };
}
