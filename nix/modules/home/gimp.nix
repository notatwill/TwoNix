{pkgs, ...}: {
  home.packages = [
    pkgs.gimp3
  ];
  vars.persistence.dirs = [".config/GIMP"];
}
