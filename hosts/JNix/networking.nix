{hostname, ...}: {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;

    # TODO: fix for Notebook vs Desktop
    # interfaces.enp5s0 = {
    #   useDHCP = true;
    #   wakeOnLan.enable = true;
    # };
  };
}
