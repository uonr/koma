{ pkgs, vscode-server, ... }:
let sshKey = builtins.readFile ./id-rsa.pub;
in {
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  users.mutableUsers = false;
  users.users.root = {
    hashedPassword = "!";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ sshKey ];
  };
  home-manager.users.root = { ... }: {
    imports = [ vscode-server.nixosModules.home ./home/basic.nix ];
  };

  users.users.mikan = {
    uid = 1000;
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    hashedPassword =
      "$6$45uxejch1jRooSUa$Ov0qhUxNSmZRmFJMTNo8/xymMXlo5LR/dYj6.A6XEij5OnWTUp7V4WlocaJgbtfiLQDB7h28PrPewsX1PpjyJ1";
    openssh.authorizedKeys.keys = [ sshKey ];
  };
  home-manager.users.mikan = { pkgs, ... }: {
    imports = [
      vscode-server.nixosModules.home
      ./home/basic.nix
      ./home/gui.nix
      ./home/development.nix
    ];
    programs.vscode = { enable = true; };
    programs.obs-studio = { enable = true; };
    home.packages = with pkgs; [ tdesktop wesnoth obsidian ];
  };
  environment.persistence."/persistent".users.mikan = {
    directories = [
      "Development"
      {
        directory = ".ssh";
        mode = "0700";
      }
      ".config/Code"
      ".config/obs-studio/"
      ".local/share/direnv"

      # TODO: move to encrypted volume
      {
        directory = ".1password";
        mode = "0700";
      }
      {
        directory = ".config/1Password";
        mode = "0700";
      }
      {
        directory = ".local/share/TelegramDesktop/";
        mode = "0700";
      }
    ];
  };
}
