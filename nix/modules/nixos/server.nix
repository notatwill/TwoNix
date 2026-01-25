_: {
  imports = [
    ./required
    ./auto-upgrade.nix
    ./fail2ban.nix
    ./gc-store.nix
    ./media-server.nix
    ./nix.nix
    ./nixpkgs.nix
    ./openssh.nix
    ./optimize-store.nix
    ./persistence.nix
    ./systemd-boot.nix
    ./wireless.nix
    ./tailscale.nix
  ];
}
