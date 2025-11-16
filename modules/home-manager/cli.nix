{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZsh = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
    };
  };
}