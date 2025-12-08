{
  inputs,
  flake,
  ...
}: {
  imports = [
    inputs.nixos-facter-modules.nixosModules.facter
    flake.nixosModules.nvidia
    {config.facter.reportPath = ./facter.json;}
  ];

  services.xserver.videoDrivers = [
    "modesetting"
  ];
  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:1:0:0";
      nvidiaBusId = "PCI:0:2:0";
    };
  };
}
