{pkgs, ...}: {
  home.packages = with pkgs; [
    activitywatch
    gnomeExtensions.color-picker
    gnomeExtensions.gsconnect
    gromit-mpx
    kdePackages.kdeconnect-kde
  ];

  services = {
    copyq.enable = true;
    network-manager-applet.enable = true;
  };
}
