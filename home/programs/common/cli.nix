{pkgs, ...}: {
  home.packages = with pkgs; [
    zoxide
    direnv
    unzip
    gnumake42
    fzf

    unzip
    atool
    file-roller
  ];

  programs = {
    feh.enable = true;
    zoxide.enable = true;
  };
}
