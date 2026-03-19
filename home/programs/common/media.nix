{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    spotify
    # pear-desktop (youtube-music)
    gthumb
  ];
}
