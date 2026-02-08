{config, ...}: {
  services.ddns-updater = {
    enable = true;
    environment.SERVER_ENABLED = "no";
  };
  environment.persistence.${config.vars.persistence.dir}.directories = ["/var/lib/private/ddns-updater/"];
}
