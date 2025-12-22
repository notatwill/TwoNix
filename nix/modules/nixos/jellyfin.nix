{config, ...}: let
  dirs = config.vars.dataDirs;
in {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    dataDir = "${dirs.media}/jellyfin";
    cacheDir = "${dirs.apps}/jellyfin/cache";
    logDir = "${dirs.apps}/jellyfin/log";
    configDir = "${dirs.apps}/jellyfin/config";
  };
  # NOTE: NEEDS TO BE LINKED TO PERSIST DIR
}
