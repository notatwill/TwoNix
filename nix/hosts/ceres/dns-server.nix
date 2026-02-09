_: {
  # networking.firewall = {
  #   allowedUDPPorts = [53];
  #   allowedTCPPorts = [53];
  # };
  # Keep resolved for local resolution, but disable its DNS server
  services.resolved.settings.Resolve = {
    DNSStubListener = "yes";
    DNSStubListenerExtra = "10.0.0.1";
  };
}
