{flake, ...}: {
  imports = [
    flake.nixosModules.nvidia
  ];
  services.xserver.videoDrivers = [
    "amdgpu"
  ];
  hardware = {
    facter.reportPath = ./facter.json;
    nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:15:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
