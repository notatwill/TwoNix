{
  config,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    signing = lib.mkIf (lib.hasAttr "ssh_signing_key" config.sops.secrets) {
      signByDefault = true;
      key = config.sops.secrets."ssh_signing_key".path;
      format = "ssh";
    };
  };
}
