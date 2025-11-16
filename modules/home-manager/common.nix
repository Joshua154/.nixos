{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    htop
    btop
    fd
    ripgrep
  ];

  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };

  home.shell = pkgs.zsh;
}