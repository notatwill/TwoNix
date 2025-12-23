{
  inputs,
  config,
  ...
}: {
  sops.secrets.vpn_key.sopsFile = inputs.secrets.ceres;
  networking.wg-quick.interfaces = {
    wg0 = {
      address = ["10.2.0.2/32"];
      dns = ["10.2.0.1"];
      privateKeyFile = config.sops.secrets.vpn_key.path;
      peers = [
        {
          publicKey = "y3Uso8csxwTGEyLSK0x+MpHifGf4onZXrV6pXL7BYAs=";
          allowedIPs = [
            "::/0"
            "0.0.0.0/0"
          ];
          endpoint = "79.127.187.246:51820";
        }
      ];
    };
  };
}
