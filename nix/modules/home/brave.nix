{pkgs, ...}: {
  home.packages = [
    pkgs.brave
  ];
  vars.persistence.dirs = [".config/BraveSoftware/Brave-Browser"];
}
