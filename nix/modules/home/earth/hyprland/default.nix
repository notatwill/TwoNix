{...}: {
  imports = [
    ./binds.nix
    ./decoration.nix
    ./general.nix
    ./misc.nix
    ./monitors.nix
    ./windowrules.nix
    ./workspaces.nix
    ./xwayland.nix
  ];
  home.sessionVariables.NIXOS_OZONE_WL = "1"; # make electron apps use wayland

  # Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # disable systemd integration to use UWSM
  };

  # Hypridle integration
  services.hypridle.settings = {
    general.after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key a second time after wake
    listener = [
      {
        timeout = "330"; # 5.5min
        on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
        on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected
      }
    ];
  };
}
