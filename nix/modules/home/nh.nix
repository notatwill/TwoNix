{pkgs, ...}: {
  home.packages = [pkgs.git]; # needed for referencing git flakes
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep-since 3d";
    };
  };
}
