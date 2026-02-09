_: {
  networking.firewall = {
    allowedUDPPorts = [53];
    allowedTCPPorts = [53];
  };
  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "wg1";
      bind-interfaces = true;
      listen-address = "10.0.0.1";
    };
  };
  # Keep resolved for local resolution, but disable its DNS server
  services.resolved.settings.Resolve.DNSStubListener = "no";
}
