{pkgs, ...}: {
  home.packages = [
    pkgs.brave
  ];
  vars.persistence.files = [
    ".pki"
    ".config/BraveSoftware/Brave-Browser"
  ];
}
