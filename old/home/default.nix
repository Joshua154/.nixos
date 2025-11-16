{ config, pkgs, lib, ... }@args:

{
  #home.username = "${username}";
  #home.homeDirectory = "/home/${username}";

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

  gtk = {
    cursorTheme = {
      name = "Future-cyan";
      size = 40;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  imports = [
    ./shell
    ./programs
    ./windowManager
  ];

  programs.home-manager.enable = true;
}
