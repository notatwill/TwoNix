{
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];
  home = {
    username = "will";
    homeDirectory = "/home/will";
  };
  sops = {
    defaultSopsFile = inputs.secrets.will;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
  };
  programs = {
    git = {
      settings.user = {
        email = "git.panic703@simplelogin.com";
        name = "notatwill";
      };
      includes = [
        {
          condition = "gitdir:~/git/github";
          contents.user.email = "30223844+notatwill@users.noreply.github.com";
        }
      ];
    };
    jujutsu.settings = {
      user = {
        email = "git.panic703@simplelogin.com";
        name = "notatwill";
      };
      "--scope" = [
        {
          "--when".repositories = ["~/git/github"];
          user.email = "30223844+notatwill@users.noreply.github.com";
        }
      ];
    };
  };
}
