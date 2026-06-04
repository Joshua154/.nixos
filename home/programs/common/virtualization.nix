{pkgs, ...}: {
  home.packages = with pkgs; [
    qemu
    spice
    spice-gtk
    virt-manager
    virt-viewer
    osinfo-db
  ];
}
