{pkgs, ...}: {
  home.packages = with pkgs; [
    zoxide
    direnv
    unzip
    gnumake42
    fzf
    ripgrep
    jq

    unzip
    atool
    file-roller
  ];

  programs = {
    atuin.enable = true;
    feh.enable = true;
    zoxide.enable = true;
  };
}
