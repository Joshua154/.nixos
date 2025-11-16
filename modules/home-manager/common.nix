{ config, pkgs, ... }:

{
  imports = [
    ./zsh
    ./programs
  ];

  home.file = {
    "Pictures" = {
      source = ./images;
      recursive = true;
    };
  };

  home.packages = with pkgs; [
    neofetch
    htop
    btop
    fd
    ripgrep
  ];


  # programs = {
  #   feh.enable = true;
  #   zoxide.enable = true;

  #   git = {
  #     enable = true;
  #     userEmail = "joshua.neunert@gmail.com";
  #     userName = "Joshua Neunert";
  #   };
  # };

  services = {
    network-manager-applet.enable = true;
    copyq.enable = true;
  };
}
