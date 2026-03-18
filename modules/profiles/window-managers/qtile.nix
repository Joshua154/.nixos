{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile = {
      enable = true;
      configFile = ../../../qtile/qtile_config.py;
    };
  };
}