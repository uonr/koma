{ pkgs, agenix, ... }: {
  environment.systemPackages = with pkgs; [
    git
    wget
    tmux
    htop
    btop
    nixfmt
    nil
    agenix # https://github.com/ryantm/agenix
  ];
  programs.mosh.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
  programs._1password-gui.enable = true;
}
