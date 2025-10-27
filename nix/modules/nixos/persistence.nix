{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.persistence;
  perUser = pred: lib.concatMap pred (lib.filter (u: u.isNormalUser) config.users.users);
in {
  options.modules.persistence = {
    dir = lib.mkOption {
      default = "/nix/persist";
      type = lib.types.str;
    };
    laDir = lib.mkOption {
      default = "/nix/persist-la";
      type = lib.types.str;
    };
  };
  imports = [inputs.impermanence.nixosModules.impermanence];
  config = {
    environment.persistence = {
      ${cfg.dir} = {
        hideMounts = true;
        directories =
          [
            "/var/lib/systemd"
            "/var/lib/nixos" # necessary nixos state
            "/var/lib/dhcpcd"
            "/var/log"
            "/var/db/sudo/lectured" # text on first sudo
          ]
          ++ lib.optional config.hardware.bluetooth.enable "/var/lib/bluetooth"
          ++ lib.optional config.services.fail2ban.enable
          {
            directory = "/var/lib/fail2ban";
            mode = "0700";
          }
          ++ lib.optional config.services.openssh.enable
          {
            directory = config.modules.openssh;
            mode = "0700";
          }
          ++ lib.optional config.services.printing.enable "/var/lib/cups"
          ++ lib.optional (lib.hasAttr "sops" config.modules) config.modules.sops.dir;
        files = [
          "/etc/adjtime"
          "/etc/machine-id" # nixos expects this
          "/var/lib/logrotate.status"
        ];
      };
      ${cfg.laDir} = {
        hideMounts = true;
        directories = lib.optionals config.programs.steam.enable perUser (
          user: [
            "${user.home}/.local/share/Steam"
            "${user.home}/.steam"
          ]
        );
      };
    };
    systemd.tmpfiles.rules = perUser (
      user: [
        "d ${cfg.dir}${user.home} ${user.homeMode} ${user.name} ${user.group}"
        "d ${cfg.laDir}${user.home} ${user.homeMode} ${user.name} ${user.group}"
      ]
    );
  };
}
