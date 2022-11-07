{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    wget
    tmux
    htop
    btop
    nixfmt
    nil
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
