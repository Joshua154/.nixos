{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    openconnect
    networkmanager
    networkmanager-openconnect
  ];
}
