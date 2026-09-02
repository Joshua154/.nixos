{host, ...}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = host.firewall.allowedTCPPorts or [];
    allowedUDPPorts = host.firewall.allowedUDPPorts or [];
  };
}
