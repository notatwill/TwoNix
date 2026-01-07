{flake, ...}: {
  imports = [
    flake.nixosModules.nvidia
  ];
  services.xserver.videoDrivers = [
    "modesetting"
  ];
  hardware = {
    facter.reportPath = ./facter.json;
    nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:1:0:0";
        nvidiaBusId = "PCI:0:2:0";
      };
    };
  };
}
