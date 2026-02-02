{
  inputs,
  config,
  ...
}: {
  sops.secrets.vpn_key = {
    sopsFile = inputs.secrets.ceres;
    mode = "640";
    owner = config.users.users.systemd-network.name;
    group = config.users.users.systemd-network.name;
  };
  networking.firewall = {
    allowedUDPPorts = [51820];
    checkReversePath = "loose";
  };
  networking.useNetworkd = true;
  systemd.network = {
    enable = true;
    networks."50-wg0" = {
      matchConfig.Name = "wg0";
      address = ["10.2.0.2/32"];

      # Use proxied DNS
      domains = ["~."];
      dns = ["10.2.0.1"];
      networkConfig.DNSDefaultRoute = true;

      # Route qbittorrent traffic
      routingPolicyRules = [
        {
          Table = 1000;
          User = config.services.qbittorrent.user;
          Priority = 100;
          Family = "both";
        }
        {
          User = config.services.qbittorrent.user;
          Priority = 200;
          Family = "both";
          Action = "reject";
        }
      ];
    };
    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };
      wireguardConfig = {
        ListenPort = 51820;
        PrivateKeyFile = config.sops.secrets.vpn_key.path;
        RouteTable = 1000;
        FirewallMark = 40;
      };
      wireguardPeers = [
        {
          PublicKey = "y3Uso8csxwTGEyLSK0x+MpHifGf4onZXrV6pXL7BYAs=";
          AllowedIPs = [
            "::/0"
            "0.0.0.0/0"
          ];
          Endpoint = ["79.127.187.246:51820"];
        }
      ];
    };
  };
}
