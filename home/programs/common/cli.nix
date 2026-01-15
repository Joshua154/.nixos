{pkgs, ...}: {
  home.packages = with pkgs; [
    zoxide
    direnv
    unzip
    gnumake42
    fzf
  ];

  programs = {
    feh.enable = true;
    zoxide.enable = true;
  };
}
