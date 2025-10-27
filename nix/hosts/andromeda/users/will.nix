{flake, ...}: {
  imports = [
    flake.homeModules.will
    flake.homeModules.earth
  ];
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
