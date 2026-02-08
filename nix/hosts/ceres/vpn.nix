{
  inputs,
  config,
  ...
}: {
  sops.secrets = {
    personal_vpn_key = {
      sopsFile = inputs.secrets.ceres;
      mode = "440";
      owner = config.users.users.systemd-network.name;
      group = config.users.users.systemd-network.group;
    };
    vpn_proxy_conf = {
      sopsFile = inputs.secrets.ceres-vpn-proxy;
      mode = "440";
      group = config.util-nixarr.globals.libraryOwner.group;
      format = "binary";
    };
  };
  nixarr = {
    transmission.peerPort = 15758;
    vpn = {
      enable = true;
      wgConf = config.sops.secrets.vpn_proxy_conf.path;
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
        address = ["10.0.0.1/24"];
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
              "10.0.0.2/32"
            ];
          }
          # sam desktop
          {
            PublicKey = "Bu8uY1wrJVfWEOf7kGuyBYfVA5d1H91FZmEF8gvlCxY=";
            AllowedIPs = [
              "10.0.0.3/32"
            ];
          }
        ];
      };
    };
  };
}
