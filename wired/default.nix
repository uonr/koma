{ lib, config, secrets, ... }:
with lib;
let cfg = config.services.wired;
in {
  options.services.wired = {
    enable = mkEnableOption "wired nebula network service";
    hostName = mkOption {
      type = types.str;
      default = config.networking.hostName;
    };
    isLighthouse = mkOption {
      type = types.bool;
      default = false;
    };
    key = mkOption { type = types.str; };
    cert = mkOption { type = types.str; };
  };

  config = mkIf cfg.enable {
    services.nebula.networks.wired = {
      enable = true;
      isLighthouse = cfg.isLighthouse;
      ca = ./ca.crt;
      key = cfg.key;
      cert = cfg.cert;
      lighthouses =
        if cfg.isLighthouse then [ ] else [ "10.110.1.1" "10.110.1.2" ];
      staticHostMap = {
        "10.110.1.1" = [ "172.104.68.197:4242" ];
        "10.110.1.2" = [ "35.200.108.79:1121" ];
      };
      firewall.outbound = [{
        port = "any";
        proto = "any";
        host = "any";
      }];
      firewall.inbound = [{
        port = "any";
        proto = "any";
        host = "any";
      }];
    };
  };
}
