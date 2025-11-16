{ config, pkgs, ... }:

{
  imports = [
    ./zsh
    ./git
  ];

  home.packages = with pkgs; [
    neofetch
    htop
    btop
    fd
    ripgrep
  ];
}