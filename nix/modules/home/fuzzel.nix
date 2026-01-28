{
  config,
  lib,
  ...
}: {
  programs.fuzzel.enable = true;
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, D, exec, uwsm app -- ${lib.getExe config.programs.fuzzel.package}"
  ];
}
