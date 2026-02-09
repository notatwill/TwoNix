{config, ...}: {
  services.dnsmasq.enable = true; # serves from /etc/hosts
  services.resolved.enable = false; # enabled by systemd networking
  environment.persistence.${config.vars.persistence.dir}.directories = ["/var/lib/dnsmasq"];
}
