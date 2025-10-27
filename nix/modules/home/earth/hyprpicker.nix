{pkgs, ...}: {
  home.packages = [
    pkgs.hyprpicker
    pkgs.wl-clipboard
  ];
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod $shiftMod, P, exec, uwsm app -- hyprpicker -ar"
  ];
}
