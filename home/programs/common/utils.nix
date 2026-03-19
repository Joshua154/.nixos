{pkgs, ...}: {
  home.packages = with pkgs; [
    activitywatch
    gromit-mpx
    kdePackages.kdeconnect-kde
    fastfetch
  ];

  services = {
    copyq.enable = true;
    network-manager-applet.enable = true;
  };
}
