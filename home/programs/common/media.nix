{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    spotify
    ffmpeg
    gthumb
  ];
}
