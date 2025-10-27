{config, ...}: let
  pDir = config.modules.persistence.dir;
  plaDir = config.modules.persistence.laDir;
in {
  environment.persistence = {
    ${plaDir}.users.will.directories = [
      "Documents"
      "Downloads"
      "Games"
      "git"
      "Music"
      "Pictures"
      "Videos"
    ];
    ${pDir}.users.will = {
      files = [
        ".bash_history"
        ".zsh_history"
      ];
      directories = [
        ".config/Bitwarden"
        ".config/BraveSoftware/Brave-Browser"
        ".config/GIMP"
        ".config/qBittorrent"
        ".config/vesktop"
        ".local/share/qBittorrent"
        ".config/uwsm"
        ".local/share/hyprland"
        ".local/share/lutris"
        ".local/share/systemd"
        ".local/state/yazi"
        ".pki/nssdb"
        {
          directory = ".config/sops/age";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };
}
