{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.sops;
in {
  options.modules.sops = {
    dir = lib.mkOption {
      default = "/var/lib/sops";
      type = lib.types.str;
    };
    keyFile = lib.mkOption {
      default = "/age/keys.txt";
      type = lib.types.str;
    };
  };
  imports = [inputs.sops-nix.nixosModules.sops];
  config = {
    sops = {
      defaultSopsFile = inputs.secrets.secrets;
      age.keyFile = "${config.modules.persistence.dir}${cfg.dir}${cfg.keyFile}";
      age.sshKeyPaths = []; # don't import any ssh keys
    };
    users.mutableUsers = false; # sops manages passwords
  };
}
