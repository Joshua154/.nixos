{ config, pkgs, libs, ... }:
{
  imports = [
    ./rocket-league.nix
  ];

  #  home.file = {
  #    ".local/share/applications" = {
  #      source = ./shortcuts;
  #      recursive = true;
  #    };
  #  };
}
