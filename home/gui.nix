{ pkgs, ... }: {
  home.packages = with pkgs; [ google-chrome firefox ];
  programs.alacritty = {
    enable = true;
    # https://github.com/alacritty/alacritty/blob/master/alacritty.yml
    settings = { window = { padding = { x = 6; }; }; };
  };
}
