{...}: {
  imports = [
    ./hyprlock
    ./binds.nix
    ./decoration.nix
    ./general.nix
    ./hyprshot.nix
    ./hyprpolkitagent.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprpicker.nix
    ./input.nix
    ./misc.nix
    ./monitors.nix
    ./windowrules.nix
    ./workspaces.nix
    ./xwayland.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # disable systemd integration to use UWSM
  };
  vars.persistence.dirs = [".local/share/hyprland"];
}
