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
      openFirewall = true;
      dataDir = "${dirs.media}/jellyfin";
      cacheDir = "${dirs.apps}/jellyfin/cache";
      logDir = "${dirs.apps}/jellyfin/log";
      configDir = "${dirs.apps}/jellyfin/config";
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
    i2pd = {
      enable = true;
      enableIPv6 = true;
      yggdrasil.enable = true;
      proto.sam.enable = true;
    };
    qbittorrent = {
      enable = true;
      openFirewall = true;
      group = group;
      user = user;
      profileDir = dirs.apps;
    };
  };
  networking.firewall.allowedTCPPorts = [80];
  systemd.tmpfiles.rules = [
    "d ${dirs.media}/live 0770 ${group} ${user} -"
    "d ${dirs.media}/live/books 0770 ${group} ${user} -"
    "d ${dirs.media}/live/movies 0770 ${group} ${user} -"
    "d ${dirs.media}/live/music 0770 ${group} ${user} -"
    "d ${dirs.media}/live/photosvideos 0770 ${group} ${user} -"
    "d ${dirs.media}/live/shows 0770 ${group} ${user} -"
    "d ${dirs.media}/torrent 0770 ${group} ${user} -"
    "d ${dirs.media}/torrent/books 0770 ${group} ${user} -"
    "d ${dirs.media}/torrent/movies 0770 ${group} ${user} -"
    "d ${dirs.media}/torrent/music 0770 ${group} ${user} -"
    "d ${dirs.media}/torrent/shows 0770 ${group} ${user} -"
    "d ${dirs.media}/usenet 0770 ${group} ${user} -"
    "d ${dirs.media}/usenet/incomplete 0770 ${group} ${user} -"
    "d ${dirs.media}/usenet/complete 0770 ${group} ${user} -"
    "d ${dirs.media}/usenet/complete/books 0770 ${group} ${user} -"
    "d ${dirs.media}/usenet/complete/movies 0770 ${group} ${user} -"
    "d ${dirs.media}/usenet/complete/music 0770 ${group} ${user} -"
    "d ${dirs.media}/usenet/complete/shows 0770 ${group} ${user} -"
  ];
}
