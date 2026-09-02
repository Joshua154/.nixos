{pkgs, ...}: {
  home.packages = with pkgs; [
    # activitywatch
    gromit-mpx
    # kdePackages.kdeconnect-kde
    kdePackages.kdenlive
    fastfetch
    nix-your-shell

    exiftool
    mediainfo
  ];

  programs = {
    yazi = {
      enable = true;
      enableBashIntegration = true;
      shellWrapperName = "y";
    };
  };

  services = {
    copyq.enable = true;
    network-manager-applet.enable = true;
  };
}
