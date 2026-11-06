{pkgs, ...}: {
  home.packages = with pkgs; [
    direnv
    unzip
    gnumake42
    fzf
    ripgrep
    jq

    atool
    file-roller
  ];

  programs = {
    atuin.enable = true;
    feh.enable = true;
    zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };
  };
}
