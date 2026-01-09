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
    radarr = {
      enable = true;
      openFirewall = true;
      group = group;
      user = user;
      dataDir = "${dirs.apps}/radarr";
    };
    sonarr = {
      enable = true;
      openFirewall = true;
      group = group;
      user = user;
      dataDir = "${dirs.apps}/sonarr";
    };
    readarr = {
      enable = true;
      openFirewall = true;
      group = group;
      user = user;
      dataDir = "${dirs.apps}/readarr";
    };
    bazarr = {
      enable = true;
      openFirewall = true;
      group = group;
      user = user;
      dataDir = "${dirs.apps}/bazarr";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
      dataDir = "${dirs.apps}/prowlarr";
    };
    # recyclarr = {
    #   enable = true;
    #   group = group;
    #   user = user;
    #   configuration = {
    #     radarr = [
    #       {
    #         api_key = {
    #           _secret = "/run/credentials/recyclarr.service/radarr-api_key";
    #         };
    #         base_url = "http://localhost:7878";
    #         instance_name = "main";
    #       }
    #     ];
    #     sonarr = [
    #       {
    #         api_key = {
    #           _secret = "/run/credentials/recyclarr.service/sonarr-api_key";
    #         };
    #         base_url = "http://localhost:8989";
    #         instance_name = "main";
    #       }
    #     ];
    #   };
    # };
    qbittorrent = {
      enable = true;
      openFirewall = true;
      group = group;
      user = user;
      profileDir = dirs.apps;
    };
    nginx.virtualHosts = {
      "media.ceres".locations."/".proxyPass = "http://127.0.0.1:8096/";
    };
  };
  networking.firewall.allowedTCPPorts = [80];
  systemd.tmpfiles.rules = [
    "d ${dirs.media}/books 0750 ${group} ${user} -"
    "d ${dirs.media}/movies 0750 ${group} ${user} -"
    "d ${dirs.media}/music 0750 ${group} ${user} -"
    "d ${dirs.media}/photosvideos 0750 ${group} ${user} -"
    "d ${dirs.media}/shows 0750 ${group} ${user} -"
  ];
}
