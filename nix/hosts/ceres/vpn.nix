{
  inputs,
  config,
  ...
}: {
  sops.secrets = {
    proton_vpn_key = {
      sopsFile = inputs.secrets.ceres;
      mode = "440";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
    };
    personal_vpn_key = {
      sopsFile = inputs.secrets.ceres;
      mode = "440";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
    };
  };
  networking = {
    useNetworkd = true;
    firewall = {
      allowedUDPPorts = [51820];
      checkReversePath = "loose";
    };
  };
  systemd.network = {
    enable = true;
    networks = {
      "50-wg1" = {
        matchConfig.Name = "wg1";
        address = ["10.1.0.1/32"];
      };
      "60-wg0" = {
        matchConfig.Name = "wg0";
        address = ["10.2.0.2/32"];
        # Use proxied DNS
        domains = ["~."];
        dns = ["10.2.0.1"];
        networkConfig.DNSDefaultRoute = true;
        # Route qbittorrent traffic
        # routingPolicyRules = [
        #   {
        #     Table = 1000;
        #     User = config.services.qbittorrent.user;
        #     Priority = 50;
        #     Family = "both";
        #   }
        # ];
      };
    };
    netdevs = {
      "50-wg1" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg1";
        };
        wireguardConfig = {
          ListenPort = 51820;
          PrivateKeyFile = config.sops.secrets.personal_vpn_key.path;
          RouteTable = 1000;
          FirewallMark = 50;
        };
        wireguardPeers = [
          {
            PublicKey = "utvNVeVF/P1+Fhwba1DiWFTGehfbI96HKgV/ts4Hxtk=";
            AllowedIPs = [
              "10.1.0.0/24"
            ];
          }
        ];
      };
      "60-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
        };
        wireguardConfig = {
          PrivateKeyFile = config.sops.secrets.proton_vpn_key.path;
          RouteTable = 2000;
          FirewallMark = 60;
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
  };
}
