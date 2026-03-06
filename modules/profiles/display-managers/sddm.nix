{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.sddm-kcm
  ];
}
