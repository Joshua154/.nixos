{ config, pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu
    spice
    spice-gtk
    virt-viewer
    virt-manager
  ];

  virtualisation.libvirtd.enable = true;
  
  users.users.${username}.extraGroups = [ "libvirtd" ];
}