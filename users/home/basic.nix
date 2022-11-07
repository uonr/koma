{ config, pkgs, ... }: {
  # https://nix-community.github.io/home-manager/options.html
  services.vscode-server.enable = true;

  imports = [ ./neovim.nix ./zsh.nix ./git.nix ];

  home.packages = with pkgs; [ ripgrep fd btop du-dust mosh python3 tealdeer ];

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    prefix = "`";
    extraConfig = ''
      set -g mouse on
    '';
    plugins = with pkgs.tmuxPlugins; [ gruvbox ];
  };

  # fzf https://github.com/junegunn/fzf#fzf-tmux-script
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    tmux.enableShellIntegration = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
