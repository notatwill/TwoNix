{
  inputs,
  config,
  ...
}: {
  sops.secrets = {
    ceres-ddns-updater = {
      sopsFile = inputs.secrets.ceres-ddns-updater;
      path = "/etc/ddns-updater/config.json";
      mode = "444";
      format = "binary";
    };
    vpn_proxy_conf = {
      sopsFile = inputs.secrets.ceres-vpn-proxy;
      mode = "440";
      format = "binary";
    };
  };
  services.ddns-updater.environment.CONFIG_FILEPATH = config.sops.secrets.ceres-ddns-updater.path;
  nixarr = {
    transmission.peerPort = 15758;
    vpn = {
      enable = true;
      wgConf = config.sops.secrets.vpn_proxy_conf.path;
    };
  };
}
