{config, ...}: {
  services.jellyseerr = {
    enable = true;
    openFirewall = true;
    configDir = "${config.vars.dataDirs.apps}/jellyseerr";
  };
}
