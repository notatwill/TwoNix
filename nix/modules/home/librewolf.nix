_: {
  programs.librewolf = {
    enable = true;
    policies = {
      BlockAboutConfig = true;
      BlockAboutProfiles = true;
      DisableAppUpdate = true;
      DisableSetDesktopBackround = true;
      DisableSystemAddonUpdate = true;
    };
  };
  vars.persistence.dirs = [".config/librewolf"];
}
