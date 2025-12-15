{flake, ...}: {
  imports = [
    flake.nixosModules.workstation
    ./disko.nix
    ./hardware.nix
    ./users.nix
  ];
  time.timeZone = "America/Chicago";
  networking.hostName = "ceres";
  networking.hostId = "e0fdcfa7"; # random, required by zfs
  system.stateVersion = "25.11";
}
