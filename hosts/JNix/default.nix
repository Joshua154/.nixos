{ config, pkgs, lib, ... }:
  
{
    imports = [
      ./nvidia.nix
      ./hardware-configuration.nix
    ];

    programs.kdeconnect.enable = true;
    
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
    
    networking = {
      hostName = "${hostname}";
      networkmanager.enable = true;
    };

    system.stateVersion = "25.05";
}
