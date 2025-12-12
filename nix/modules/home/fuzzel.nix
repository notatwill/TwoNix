_: {
  programs.fuzzel.enable = true;
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, D, exec, uwsm app -- fuzzel"
  ];
}
