{ pkgs, config, ... }:
let sshKey = builtins.readFile ../keys/id-rsa.kiyomi.pub;
in {
  age.secrets.mikanPassword.file = ../secrets/mikan.password.age;
  users.users.mikan = {
    uid = 1000;
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    passwordFile = config.age.secrets.mikanPassword.path;
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
