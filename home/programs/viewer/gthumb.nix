{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gthumb
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/jpeg"  = [ "gthumb.desktop" ];
      "image/png"   = [ "gthumb.desktop" ];
      "image/webp"  = [ "gthumb.desktop" ];
      "image/tiff"  = [ "gthumb.desktop" ];
      "image/heif"  = [ "gthumb.desktop" ];
    };
  };
}
