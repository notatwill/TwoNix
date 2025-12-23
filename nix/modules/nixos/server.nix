_: {
  imports = [
    ./required
    ./auto-upgrade.nix
    ./fail2ban.nix
    ./gc-store.nix
    ./jellyfin.nix
    ./lidarr.nix
    ./nix.nix
    ./nixpkgs.nix
    ./openssh.nix
    ./optimize-store.nix
    ./persistence.nix
    ./qbittorrent-server.nix
    ./systemd-boot.nix
    ./wireless.nix
  ];
}
