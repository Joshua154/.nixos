#
# SHARED system-level configuration
#

{ config, pkgs, username, ... }:

{
  imports = [
    ./../modules/nixos/common-settings.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  
  nixpkgs.config.allowUnfree = true;
}