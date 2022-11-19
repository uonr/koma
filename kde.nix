{ config, pkgs, lib, ... }: {
  config = lib.mkIf (config.desktop == "kde") {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver.desktopManager.plasma5.useQtScaling = true;
    services.xserver.desktopManager.plasma5.excludePackages =
      with pkgs.libsForQt5;
      [ khelpcenter ];
    environment.systemPackages = with pkgs.libsForQt5; [ yakuake bluedevil ];
  };
}
