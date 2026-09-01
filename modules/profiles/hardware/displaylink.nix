{...}: {
  # USB graphics used by docks such as the HP USB-C/A Universal Dock G2.
  # The NixOS DisplayLink module installs DisplayLinkManager and builds the
  # matching EVDI kernel module for the selected kernel.
  services.xserver.videoDrivers = ["displaylink"];
}
