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
    firewall.allowedUDPPorts = [51820];
  };
  systemd.network = {
    enable = true;
    networks = {
      "50-wg0" = {
        matchConfig.Name = "wg0";
        address = ["10.0.0.1/32"];
      };
    };
    netdevs = {
      "50-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
        };
        wireguardConfig = {
          ListenPort = 51820;
          PrivateKeyFile = config.sops.secrets.personal_vpn_key.path;
          RouteTable = "main";
        };
        wireguardPeers = [
          # andromeda
          {
            PublicKey = "7ZLGJ8bowq9sDPkNYBXFfQKEoVbFdMAkqW7xQqYwJXM=";
            AllowedIPs = [
              "10.0.0.0/24"
            ];
          }
          # sam desktop
          {
            PublicKey = "Bu8uY1wrJVfWEOf7kGuyBYfVA5d1H91FZmEF8gvlCxY=";
            AllowedIPs = [
              "10.0.0.0/24"
            ];
          }
        ];
      };
    };
  };
}
