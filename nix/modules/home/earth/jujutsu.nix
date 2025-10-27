{config, ...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      signing = {
        behavior = "drop";
        backend = "ssh";
        key = config.sops.secrets."ssh_signing_key".path;
      };
      git.sign-on-push = false; # change to true later https://github.com/jj-vcs/jj/issues/7853
    };
  };
}
