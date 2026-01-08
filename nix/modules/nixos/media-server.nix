{config, ...}: let
  dirs = config.vars.dataDirs;
  group = "media";
  user = "media";
in {
  users.groups.${group}.gid = 101;
  users.users.${user} = {
    uid = 101;
    group = group;
  };
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      group = group;
      user = user;
      dataDir = "${dirs.media}/jellyfin";
      cacheDir = "${dirs.apps}/jellyfin/cache";
      logDir = "${dirs.apps}/jellyfin/log";
      configDir = "${dirs.apps}/jellyfin/config";
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
      configDir = "${dirs.apps}/jellyseerr";
    };
    lidarr = {
      enable = true;
      openFirewall = true;
      group = group;
      user = user;
      dataDir = "${dirs.apps}/lidarr";
    };
    qbittorrent = {
      enable = true;
      openFirewall = true;
      group = group;
      profileDir = dirs.apps;
    };
  };
  systemd.tmpfiles.rules = [
    "d ${dirs.media}/books 0750 ${group} ${user} -"
    "d ${dirs.media}/movies 0750 ${group} ${user} -"
    "d ${dirs.media}/music 0750 ${group} ${user} -"
    "d ${dirs.media}/photosvideos 0750 ${group} ${user} -"
    "d ${dirs.media}/shows 0750 ${group} ${user} -"
  ];
}
