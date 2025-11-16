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
      ./../../modules/home-manager/cli.nix
      ./../../modules/home-manager/git.nix
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