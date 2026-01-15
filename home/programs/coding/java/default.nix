{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    jdk17_headless
    gradle
  ];
}
