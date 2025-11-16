{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    gamemode
    mangohud
    prismlauncher
    legendary-gl
  ];

  programs.gamemode.enable = true;
}