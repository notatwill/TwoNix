{config, ...}: {
  sops.secrets."ssh_key".path = "${config.home.homeDirectory}/.ssh/${config.home.username}";
  sops.secrets."ssh_signing_key".path = "${config.home.homeDirectory}/.ssh/${config.home.username}-sign";
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        host = "*";
        identityFile = config.sops.secrets."ssh_key".path;
        hashKnownHosts = true;
      };
      "github.com" = {
        host = "github.com";
        addKeysToAgent = "1h";
      };
    };
  };
}
