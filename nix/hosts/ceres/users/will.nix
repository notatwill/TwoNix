{flake, ...}: {
  imports = [
    flake.homeModules.will
    flake.homeModules.desolate
  ];
  home.stateVersion = "25.11";
}
