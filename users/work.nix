{ pkgs, vscode-server, ... }:
let sshKey = builtins.readFile ./id-rsa.pub;
in {
  users.users.mikan = {
    uid = 1000;
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "video" "audio" "networkmanager" ];
    hashedPassword =
      "$6$9HWDx3n2yMaMOoow$Lv1nf27ewS38sTniR4zOomOwk7gAG1ZiESYeriIGfM0JER3ZFlTUY7.CCVm0VHnElaNGg/ktU/V804HscoEbb.";
    openssh.authorizedKeys.keys = [ sshKey ];
  };
  home-manager.users.mikan = { pkgs, ... }: {
    imports = [ ./home vscode-server.nixosModules.home ];
    home.my = {
      enable = true;
      development = true;
      gui = true;
      entertainment = true;
    };
    programs.vscode = { enable = true; };
    home.packages = with pkgs; [ teams ];
  };
  environment.persistence."/persistent".users.mikan = {
    directories = [
      "Development"
      {
        directory = ".ssh";
        mode = "0700";
      }
      ".config/Code"
      ".local/share/direnv"
    ];
  };
}
