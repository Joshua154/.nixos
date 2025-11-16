#
# SHARED NixOS modules
#

{ config, pkgs, ... }:

{
  imports = [
    ./boot
    ./openconnect.nix
  ];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    zsh
  ];

  programs.zsh.enable = true;
}