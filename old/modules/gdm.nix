{ config, pkgs, inputs, ... }:
{
  services.xserver.displayManager.gdm.enable = true;
}
