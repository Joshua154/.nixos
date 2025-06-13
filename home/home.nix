{ config, pkgs, lib, ... }@args:

{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
  home.file = {
    "Pictures" = {
      source = ./images;
      recursive = true;
    };
  };

  imports = [
    ./shell
  ];

  programs.home-manager.enable = true;
}
