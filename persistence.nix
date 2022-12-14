{
  # https://nixos.wiki/wiki/Impermanence
  # https://github.com/nix-community/impermanence
  # https://elis.nu/blog/2020/06/nixos-tmpfs-as-home/
  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/systemd/coredump"
      "/etc/ssh"
      "/etc/NetworkManager/system-connections"
      # {
      #   directory = "/var/lib/colord";
      #   user = "colord";
      #   group = "colord";
      #   mode = "0750";
      # }
    ];
    files = [
      "/etc/machine-id"
      # {
      #   file = "/etc/nix/id_rsa";
      #   parentDirectory = { mode = "0755"; };
      # }
    ];
  };
}
