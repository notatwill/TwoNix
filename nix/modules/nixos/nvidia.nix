{config, ...}: {
  vars.unfreePkgs = [
    "nvidia-x11"
    "nvidia-persistenced"
  ];
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = true;
    nvidiaSettings = false;
    open = true;
  };
}
