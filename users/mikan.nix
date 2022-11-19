{ pkgs, config, ... }:
let sshKey = builtins.readFile ../keys/id-rsa.kiyomi.pub;
in {
  users.users.mikan = {
    uid = 1000;
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    hashedPassword =
      "$6$xUup8plOl41Al1Fa$VpR3G/tKM6jzm05Rr9hHGPPAFzKWykmEJJPw6GO9i7GJj7QnFSzFyiyA48/u1myzrQOrwn8ckQk2TJln4lq/w1";
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
    home.file = { ".config/sway/config" = { source = ../sway.conf; }; };

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
      ".local/share/fcitx5/rime"
      ".config/fcitx5"

      # TODO: move to encrypted volume
      {
        directory = ".mozilla/firefox";
        mode = "0700";
      }
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
