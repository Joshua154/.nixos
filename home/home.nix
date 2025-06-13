{ config, pkgs, lib, ... }@args:

{
  home.username = "joshua";
  home.homeDirectory = "/home/joshua";

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
  home.sessionVariables = { 
    #EDITOR = "nvim"; 
    #ZDOTDIR = "/home/joshua";
  };

  imports = [
    ./zsh
    ./neovim
  ];

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

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      font-size = 14;
      background-blur-radius = 20;
      mouse-hide-while-typing = true;
      window-decoration = true;
      # keybind = global:cmd+/=toggle_quick_terminal;
      macos-option-as-alt = true;
      # background-opacity = 0.7;
      # background-blur-radius = 20;
    };
    #enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
