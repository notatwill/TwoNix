{config, ...}: {
  networking.firewall = {
    allowedUDPPorts = [53];
    allowedTCPPorts = [53];
  };
  services = {
    dnsmasq.enable = true; # serves from /etc/hosts
    resolved.enable = false; # enabled by systemd networking
  };
  environment.persistence.${config.vars.persistence.dir}.directories = ["/var/lib/dnsmasq"];
}
