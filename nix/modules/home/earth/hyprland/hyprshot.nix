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
}
