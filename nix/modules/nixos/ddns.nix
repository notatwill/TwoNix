_: {
  services.ddns-updater = {
    enable = true;
    environment.SERVER_ENABLED = "no";
  };
}
