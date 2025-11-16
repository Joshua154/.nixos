{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    gamemode
    mangohud
  ];

  programs.gamemode.enable = true;
}