{
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [22];

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
}
