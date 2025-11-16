{ config, pkgs, inputs, hostname, username, system, ... }:

{
  imports = [
    ./grub
  ];

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

    plymouth = {
      enable = true;
      theme = "bgrt"; #breeze
    };
    kernelParams = [ "quiet" "splash" ];
  };
}
