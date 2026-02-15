{inputs, ...}: {
  imports = [inputs.impermanence.nixosModules.impermanence];
  environment.defaultPackages = [];
}
