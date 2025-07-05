{ config, pkgs, inputs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  
#  services.xserver.displayManager.sddm.theme = "breeze"; # or "maya", "elarun", "maldives", etc.
  
  environment.systemPackages = with pkgs; [
    libsForQt5.sddm-kcm
#    plasma5Packages.breeze
  ];
}
