{config, ...}: {
  services.dnsmasq.enable = true; #serves from /etc/hosts
  environment.persistence.${config.vars.persistence.dir}.directories = ["/var/lib/dnsmasq"];
}
