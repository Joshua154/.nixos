{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      3000
      8080 # for web services
      3160
    ];
  };
}
