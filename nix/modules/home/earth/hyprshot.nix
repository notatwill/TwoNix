{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.hyprshot = {
    enable = true;
    saveLocation = "${config.home.homeDirectory}/Pictures/hyprshot";
  };
  wayland.windowManager.hyprland.settings.bind = [
    (''$mainMod, P, exec, uwsm app -- hyprshot -m region -z''
      + lib.optionalString (lib.elem pkgs.satty config.home.packages) " --raw | satty -f -")
  ];
}
