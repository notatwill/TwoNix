{
  inputs,
  config,
  ...
}: {
  sops.secrets.ceres-ddns-updater = {
    sopsFile = inputs.secrets.ceres-ddns-updater;
    path = "/etc/ddns-updater/config.json";
    mode = "444";
    format = "binary";
  };
  services.ddns-updater.environment.CONFIG_FILEPATH = config.sops.secrets.ceres-ddns-updater.path;
}
