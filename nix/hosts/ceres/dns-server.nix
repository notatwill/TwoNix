{config, ...}: {
  networking.firewall = {
    allowedUDPPorts = [53];
    allowedTCPPorts = [53];
  };
  services.resolved.settings.Resolve = {
    DNSStubListener = "yes";
    DNSStubListenerExtra = "0.0.0.0:53";
  };
  environment.persistence.${config.vars.persistence.dir}.directories = ["/var/lib/dnsmasq"];
}
