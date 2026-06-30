{pkgs, ...}: {
  home.packages = with pkgs; [
    # activitywatch
    gromit-mpx
    # kdePackages.kdeconnect-kde
    kdePackages.kdenlive
    fastfetch
    nix-your-shell
  ];

  services = {
    copyq.enable = true;
    network-manager-applet.enable = true;
  };
}
