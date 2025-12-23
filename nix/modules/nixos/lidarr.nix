{config, ...}: {
  services.lidarr = {
    enable = true;
    openFirewall = true;
    user = config.services.jellyfin.user;
    group = config.services.jellyfin.group;
    dataDir = "${config.vars.dataDirs.apps}/lidarr";
  };
}
