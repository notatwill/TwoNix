{pkgs, ...}: {
  home.packages = [
    pkgs.qbittorrent-enhanced
  ];
  vars.persistence.dirs = [".local/share/qBittorrent" ".config/qBittorrent"];
}
