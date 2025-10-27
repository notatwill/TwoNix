{
  config,
  lib,
  ...
}: let
  cfg = config.modules.nixpkgs;
in {
  options.modules.nixpkgs = {
    unfree = lib.mkOption {
      default = [];
      type = lib.types.listOf lib.types.str;
    };
  };
  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) cfg.unfree;
  };
}
