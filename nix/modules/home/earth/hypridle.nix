_: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [
        {
          timeout = "300";
          on-timeout = "loginctl lock-session";
        }
        # {
        #   timeout = "1800"; # 30min
        #   on-timeout = "systemctl suspend"; # suspend pc
        # }
      ];
    };
  };
}
