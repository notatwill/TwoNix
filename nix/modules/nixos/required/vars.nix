{lib, ...}: {
  options.vars = {
    persistence = {
      enable = lib.mkEnableOption "impermanence";
      dir = lib.mkOption {
        default = "/nix/persist";
        type = lib.types.str;
      };
      laDir = lib.mkOption {
        default = "/nix/persist-la";
        type = lib.types.str;
      };
    };
    dataDirs = {
      media = lib.mkOption {
        default = "/srv/media";
        type = lib.types.str;
      };
      archive = lib.mkOption {
        default = "/srv/archive";
        type = lib.types.str;
      };
      db = lib.mkOption {
        default = "/srv/db";
        type = lib.types.str;
      };
      apps = lib.mkOption {
        default = "/srv/apps";
        type = lib.types.str;
      };
    };
    unfreePkgs = lib.mkOption {
      default = [];
      type = lib.types.listOf lib.types.str;
    };
    openssh = {
      keyDir = lib.mkOption {
        default = "/etc/ssh/ssh_host_keys";
        type = lib.types.str;
      };
    };
  };
}
