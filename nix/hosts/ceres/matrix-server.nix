{config, ...}: let
  dirs = config.vars.dataDirs;
  ports = config.services.matrix-tuwunel.settings.global.port;
in {
  networking.firewall.allowedTCPPorts = ports;
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];
  services = {
    matrix-tuwunel = {
      enable = true;
      settings.global = {
        address = ["0.0.0.0" "::"];
        server_name = "jort.pavilion";
        database_backup_path = "${dirs.archive}/tuwunel";
        database_backup_paths_to_keep = 2;
        ip_lookup_strategy = 4;
        encryption_enabled_by_default_for_room_type = "all";
      };
    };
    mautrix-discord = {
      enable = true;
      settings = {
        homeserver = {
          domain = config.services.matrix-tuwunel.settings.global.server_name;
          address = "http://127.0.0.1:${toString (builtins.elemAt ports 0)}/";
        };
        bridge.permissions = {
          "*" = "relay";
          "@hybrideology:matrix.org" = "admin";
        };
      };
    };
  };
}
