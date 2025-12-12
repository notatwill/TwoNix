_: {
  services.mako = {
    enable = true;
    settings.max-history = 50;
  };
  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app -- mako"
  ];
}
