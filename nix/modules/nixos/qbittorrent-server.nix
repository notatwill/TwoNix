{config, ...}: {
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    user = config.services.jellyfin.user;
    group = config.services.jellyfin.group;
    profileDir = config.vars.dataDirs.apps;
  };
}
