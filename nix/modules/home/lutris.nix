{
  osConfig,
  pkgs,
  ...
}: {
  programs.lutris = {
    enable = true;
    protonPackages = [pkgs.proton-ge-bin];
    steamPackage = osConfig.programs.steam.package;
    winePackages = [pkgs.wineWow64Packages.full];
  };
  vars.persistence.dirs = [".local/share/lutris"];
}
