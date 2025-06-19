{ config, pkgs, hostname, username, ... }:
  
{
    imports = [
      ../../modules/system.nix

      ./nvidia.nix
      ./hardware-configuration.nix
    ];

    programs.kdeconnect.enable = true;
    
    boot = {
      loader = {
        systemd-boot.enable = false;
        efi = {
          canTouchEfiVariables = false;
          efiSysMountPoint = "/boot";
        };
        grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          devices = [ "nodev" ];
        };
      };
    };

    nixpkgs.config.allowUnfree = true;
    
    networking = {
      hostName = "${hostname}";
      networkmanager.enable = true;
    };

    system.stateVersion = "25.05";
}
