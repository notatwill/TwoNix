{config, ...}: let
  dirs = config.vars.dataDirs;
  torrentGroup = "torrent";
  usenetGroup = "usenet";
  serveGroup = "serve";
in {
  users.groups.${torrentGroup}.gid = 101;
  users.groups.${usenetGroup}.gid = 102;
  users.groups.${serveGroup}.gid = 103;
  users.users.${config.services.jellyfin.user}.extraGroups = [serveGroup];
  users.users.${config.services.lidarr.user}.extraGroups = [torrentGroup usenetGroup serveGroup];
  users.users.${config.services.radarr.user}.extraGroups = [torrentGroup usenetGroup serveGroup];
  users.users.${config.services.sonarr.user}.extraGroups = [torrentGroup usenetGroup serveGroup];
  users.users.${config.services.readarr.user}.extraGroups = [torrentGroup usenetGroup serveGroup];
  users.users.${config.services.bazarr.user}.extraGroups = [serveGroup];
  users.users.${config.services.qbittorrent.user}.extraGroups = [torrentGroup];
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      dataDir = "${dirs.media}/jellyfin";
      cacheDir = "${dirs.apps}/jellyfin/cache";
      logDir = "${dirs.apps}/jellyfin/log";
      configDir = "${dirs.apps}/jellyfin/config";
    };
    lidarr = {
      enable = true;
      openFirewall = true;
      dataDir = "${dirs.apps}/lidarr";
    };
    radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "${dirs.apps}/radarr";
    };
    sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "${dirs.apps}/sonarr";
    };
    readarr = {
      enable = true;
      openFirewall = true;
      dataDir = "${dirs.apps}/readarr";
    };
    bazarr = {
      enable = true;
      openFirewall = true;
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
    i2pd = {
      enable = true;
      enableIPv6 = true;
      yggdrasil.enable = true;
      proto.sam.enable = true;
    };
    qbittorrent = {
      enable = true;
      profileDir = dirs.apps;
    };
  };
  networking.firewall.allowedTCPPorts = [80];
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedBrotliSettings = true;
    virtualHosts = {
      "ceres.lan".locations."/".proxyPass = "http://127.0.0.1:8080";
    };
  };
  systemd.tmpfiles.rules = [
    "d ${dirs.apps}/jellyfin 0700 ${config.services.jellyfin.group} ${config.services.jellyfin.user} -"
    "d ${dirs.media}/live 0770 root ${serveGroup} -"
    "d ${dirs.media}/live/books 0770 root ${serveGroup} -"
    "d ${dirs.media}/live/movies 0770 root ${serveGroup} -"
    "d ${dirs.media}/live/music 0770 root ${serveGroup} -"
    "d ${dirs.media}/live/photosvideos 0770 root ${serveGroup} -"
    "d ${dirs.media}/live/shows 0770 root ${serveGroup} -"
    "d ${dirs.media}/torrent 0770 root ${torrentGroup} -"
    "d ${dirs.media}/torrent/books 0770 root ${torrentGroup} -"
    "d ${dirs.media}/torrent/movies 0770 root ${torrentGroup} -"
    "d ${dirs.media}/torrent/music 0770 root ${torrentGroup} -"
    "d ${dirs.media}/torrent/shows 0770 root ${torrentGroup} -"
    "d ${dirs.media}/usenet 0770 root ${usenetGroup} -"
    "d ${dirs.media}/usenet/incomplete 0770 root ${usenetGroup} -"
    "d ${dirs.media}/usenet/complete 0770 root ${usenetGroup} -"
    "d ${dirs.media}/usenet/complete/books 0770 root ${usenetGroup} -"
    "d ${dirs.media}/usenet/complete/movies 0770 root ${usenetGroup} -"
    "d ${dirs.media}/usenet/complete/music 0770 root ${usenetGroup} -"
    "d ${dirs.media}/usenet/complete/shows 0770 root ${usenetGroup} -"
  ];
}
