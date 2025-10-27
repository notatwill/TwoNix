{config, lib, ...}: let
  cfg = config.modules.openssh;
in {
  options.modules.openssh = {
    keyDir = lib.mkOption {
      default = "/etc/ssh/ssh_host_keys";
      type = lib.types.str;
    };
  };
  config = {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
      hostKeys = [
        {
          bits = 4096;
          path = "${cfg.keyDir}/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          path = "${cfg.keyDir}/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
  };
}
