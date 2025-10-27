{
  config,
  lib,
  ...
}: let
  cfg = config.vars.persistence;
in {
  config = {
    environment.persistence = {
      ${cfg.dir} = {
        inherit (cfg) enable;
        hideMounts = true;
        directories =
          [
            "/var/lib/systemd"
            "/var/lib/nixos"
            "/var/log"
          ]
          ++ lib.optional config.networking.dhcpcd.enable "/var/lib/dhcpcd"
          ++ lib.optional config.security.sudo.enable "/var/db/sudo";
        files =
          [
            "/etc/adjtime"
            "/etc/machine-id" # nixos expects this
          ]
          ++ lib.optional config.services.logrotate.enable "/var/lib/logrotate.status";
      };
      ${cfg.laDir} = {
        inherit (cfg) enable;
        hideMounts = true;
      };
    };
  };
}
