{ config, pkgs, lib, ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      hide_borders = false;
      margin_box = "vcenter";
      clear_password = true;
    };
  };
}
