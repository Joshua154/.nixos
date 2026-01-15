{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    desktopManager.gnome.enable = true;

    # displayManager.sddm.enable = true;
  };

  xdg = {
    portal.enable = true;
    mime.defaultApplications = {
      "image/jpeg" = ["qimgv.desktop"];
      "image/jpg" = ["qimgv.desktop"];
      "image/png" = ["qimgv.desktop"];
    };
  };
}
