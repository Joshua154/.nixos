{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    openconnect
    networkmanagerapplet
    networkmanager
    networkmanager-openconnect
  ];

  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openconnect
  ];
}
