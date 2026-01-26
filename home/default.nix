{pkgs, ...}: {
  imports = [
    ./programs
    ./shell
    ./windowManager
  ];

  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

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
    name = "Bibata-Modern-Ice";
    size = 22;
    package = pkgs.bibata-cursors;
    gtk.enable = true;
  };

  programs.home-manager.enable = true;
}
