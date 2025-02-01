{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    userName = "Joshua5e0";
    userEmail = "joshua.neunert@gmail.com";
    delta = {
      enable = true;
    };
  };
}
