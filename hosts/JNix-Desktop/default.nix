#
# DESKTOP specific configuration
#

{ config, pkgs, pkgs-unstable, username, version, ... }:

{
  imports = [
    ./../../modules/nixos/gaming.nix
    ./../../modules/nixos/nvidia.nix
  ];

  system.stateVersion = version;

  home-manager.users.${username} = {
    imports = [
      ./../../modules/home-manager/common.nix
      ./../../modules/home-manager/cli.nix
      ./../../modules/home-manager/git.nix
      # ./../../modules/home-manager/hyprland.nix
    ];

    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = version;

    _module.specialArgs = { inherit pkgs-unstable username version; };

    home.packages = [
      pkgs.steam
    ];
  };
}