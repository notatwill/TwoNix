_: {
  programs.librewolf = {
    enable = true;
    # policies = {
    #   BlockAboutConfig = true;
    #   BlockAboutAddons = true;
    #   BlockAboutProfiles = true;
    #   AutofillAddressEnabled = false;
    #   AutofillCreditCardEnabled = false;
    #   CaptivePortal = true; # allows detection of captive portals
    #   DisableAppUpdate = true;
    #   DisableFirefoxAccounts = true;
    #   DisableFirefoxStudies = true;
    #   DisablePocket = true;
    #   DisableSetDesktopBackround = true;
    #   DisableSystemAddonUpdate = true;
    #   DisableTelemetry = true;
    #   DontCheckDefaultBrowser = true;
    #   EnableTrackingProtection = true;
    #   FirefoxHome = {
    #     SponsoredTopSites = false;
    #     Highlights = false;
    #     SponsoredPocket = false;
    #     SponsoredStories = false;
    #   };
    #   FirefoxSuggest = {
    #     SponsoredSuggestions = false;
    #     ImproveSuggest = false;
    #   };
    #   HardwareAcceleration = true;
    #   GenerativeAI.Enabled = false;
    # };
  };
  vars.persistence.dirs = [".config/librewolf"];
}
