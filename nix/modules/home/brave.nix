{pkgs, ...}: {
  home.packages = [
    pkgs.brave
  ];
  vars.persistence.files = [".config/BraveSoftware/Brave-Browser"];
}
