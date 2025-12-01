{flake, ...}: {
  imports = [
    flake.nixosModules.workstation
    ./disko.nix
    ./hardware.nix
    ./users.nix
  ];
  time.timeZone = "America/Chicago";
  networking.hostName = "betelgeuse";
  networking.hostId = "1352f34a"; # random, required by zfs
  system.stateVersion = "25.05";
}
