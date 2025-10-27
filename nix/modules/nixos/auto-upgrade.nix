{flake, ...}: {
  system.autoUpgrade = {
    enable = true;
    flake = flake.outPath;
    flags = ["-L"];
    dates = "02:00";
    randomizedDelaySec = "1800";
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };
}
