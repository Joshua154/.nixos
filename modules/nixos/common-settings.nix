#
# SHARED NixOS modules
#

{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    zsh
  ];

  zsh.enable = true;
}