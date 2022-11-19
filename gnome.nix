{ config, pkgs, lib, ... }: {
  config = lib.mkIf (config.desktop == "gnome") {
    services.xserver.enable = true;
    # see https://nixos.wiki/wiki/GNOME
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.autoSuspend = false;
    services.xserver.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      gnome.cheese
      gnome.tali
      gnome.iagno
      gnome.hitori
      gnome.atomix
      gnome.gnome-music
      gnome-tour
      gnome-connections
      gnome.gnome-terminal
    ];
    environment.systemPackages = with pkgs; [
      gnomeExtensions.appindicator
      blackbox-terminal
    ];
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  };
}
