{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    spotify
    ffmpeg
    # pear-desktop (youtube-music)
    gthumb
  ];
}
