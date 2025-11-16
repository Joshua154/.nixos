#
# LAPTOP specific configuration
#

{ config, pkgs, pkgs-unstable, username, version, ... }:

{
  imports = [];

  system.stateVersion = version;

  services.blueman.enable = true;

  home-manager.users.${username} = {
    imports = [
      ./../../modules/home-manager/common.nix
    ];

    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = version;
    
    _module.specialArgs = { inherit pkgs-unstable username version; };

    home.packages = [
      pkgs.blueman
    ];
  };
}