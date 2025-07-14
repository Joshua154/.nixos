{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    openconnect
    networkmanager
    networkmanager-openconnect
#    networkmanager-openconnect-gnome
  ];
}
