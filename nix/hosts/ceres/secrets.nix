{
  inputs,
  config,
  ...
}: {
  sops.secrets.ceres-ddns-updater = {
    sopsFile = inputs.secrets.ceres-ddns-updater;
    owner = "ddns-updater";
    group = "ddns-updater";
    format = "binary";
  };
  services.ddns-updater.environment.CONFIG_FILEPATH = config.sops.secrets.ceres-ddns-updater.path;
}
