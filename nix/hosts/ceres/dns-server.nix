_: {
  networking.firewall = {
    allowedUDPPorts = [53];
    allowedTCPPorts = [53];
  };
  services.resolved.settings.Resolve = {
    DNSStubListener = "yes";
    DNSStubListenerExtra = "10.0.0.1";
  };
}
