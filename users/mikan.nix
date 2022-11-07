{ pkgs, ... }:
let sshKey = builtins.readFile ./id-rsa.pub;
in {
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
    home.my = {
      enable = true;
      development = true;
      gui = true;
      entertainment = true;
    };
    programs.git = {
      userEmail = "me@yuru.me";
      userName = "Tachibana Kiyomi";
    };
    programs.vscode = { enable = true; };
    programs.obs-studio = { enable = true; };
    home.packages = with pkgs; [ tdesktop wesnoth minecraft obsidian ];
  };
  environment.persistence."/persistent".users.mikan = {
    directories = [
      "Development"
      {
        directory = ".ssh";
        mode = "0700";
      }
      ".vscode"
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
