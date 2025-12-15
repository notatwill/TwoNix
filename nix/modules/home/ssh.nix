_: {
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        host = "*";
        hashKnownHosts = true;
      };
      "github.com" = {
        host = "github.com";
        addKeysToAgent = "1h";
      };
    };
  };
  vars.persistence.dirs = [
    {
      directory = ".ssh";
      mode = "0700";
    }
  ];
}
