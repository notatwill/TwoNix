{
  inputs,
  config,
  ...
}: {
  sops.secrets.personal_vpn_key = {
    sopsFile = inputs.secrets.ceres;
    mode = "440";
    owner = config.users.users.systemd-network.name;
    group = config.users.users.systemd-network.group;
  };
  networking = {
    hosts."10.0.0.1" = ["ceres.vpn"];
    useNetworkd = true;
    firewall.allowedUDPPorts = [51820];
  };
  systemd.network = {
    enable = true;
    networks = {
      "60-wg1" = {
        matchConfig.Name = "wg1";
        address = ["10.0.0.1/24"];
      };
    };
    netdevs = {
      "60-wg1" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg1";
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
          # graphene
          {
            PublicKey = "g3k/Jr9xGBA5/biBHfpuibWcnksyoYYtVdY/MamXcB4=";
            AllowedIPs = [
              "10.0.0.4/32"
            ];
          }
        ];
      };
    };
  };
}
