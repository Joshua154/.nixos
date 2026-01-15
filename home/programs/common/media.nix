{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    spotify
    youtube-music
    gthumb
  ];
}
