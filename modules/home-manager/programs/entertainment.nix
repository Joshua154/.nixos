{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    spotify
    youtube-music
    wineWowPackages.stable
  ];
}