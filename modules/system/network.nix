{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      80
      443
      3000
      8080 # for web services
    ];
  };
}
