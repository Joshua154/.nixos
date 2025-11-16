{ config, pkgs, username, ... }:

{
  programs.git = {
    enable = true;
    userName = "Joshua";
    userEmail = "joshua@example.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}