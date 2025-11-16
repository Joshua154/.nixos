{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gromit-mpx
    obsidian
    pureref
    pdfarranger
    zathura
    termius
    celluloid
    thunderbird
    bitwarden
    httpie-desktop
    burpsuite

    gnomeExtensions.gsconnect
  ];
}