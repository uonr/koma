# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./hardware.nix
    # Desktop
    ./font.nix
    ./gnome.nix
    ./kde.nix
    ./sway.nix

    ./nix.nix
    ./users
    ./tools.nix
    ./virtualisation.nix
    ./keymap.nix
    ./ime.nix
    ./persistence.nix
  ];
  options = { desktop = lib.mkOption { type = lib.types.str; }; };
  config = {
    desktop = "sway";

    networking.hostName = "koma"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable =
      true; # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "Asia/Tokyo";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      # font = "Lat2-Terminus16";
      useXkbConfig = true; # use xkbOptions in tty.
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    programs.zsh.enable = true;

    # List services that you want to enable:

    services.vscode-server.enable = true;

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "prohibit-password";
      openFirewall = true;
    };

    age.secrets.wiredHostKey.file = ./secrets/wired.host.key.age;
    age.secrets.wiredHostCert.file = ./secrets/wired.host.crt.age;
    services.wired = {
      enable = true;
      key = config.age.secrets.wiredHostKey.path;
      cert = config.age.secrets.wiredHostCert.path;
    };

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ ];
    networking.firewall.allowedUDPPorts = [ ];
    # Or disable the firewall altogether.
    networking.firewall.enable = true;

    security.polkit.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.05"; # Did you read the comment?
  };
}
