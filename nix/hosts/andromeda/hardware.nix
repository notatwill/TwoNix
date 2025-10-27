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

  hardware.nvidia = {
    prime = {
      sync.enable = true;
      amdgpuBusId = "PCI:15:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
