{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    jdk17
    gradle
  ];
}
