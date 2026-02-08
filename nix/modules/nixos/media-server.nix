{
  config,
  inputs,
  ...
}: let
  dirs = config.vars.dataDirs;
  torrentGroup = "torrent";
  usenetGroup = "usenet";
  serveGroup = "serve";
in {
  imports = [inputs.nixarr.nixosModules.default];
  nixarr = {
    enable = true;
    transmission = {
      enable = true;
      vpn.enable = true;
    };
  };
  users.groups.${torrentGroup}.gid = 101;
  users.groups.${usenetGroup}.gid = 102;
  users.groups.${serveGroup}.gid = 103;
  users.users.${config.services.jellyfin.user}.extraGroups = [serveGroup];
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      dataDir = "${dirs.media}/jellyfin";
      cacheDir = "${dirs.apps}/jellyfin/cache";
      logDir = "${dirs.apps}/jellyfin/log";
      configDir = "${dirs.apps}/jellyfin/config";
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
