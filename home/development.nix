{ pkgs, ... }: {

  home.packages = with pkgs; [
    ripgrep
    fd
    btop
    jq
    shellcheck
    rustup
    yt-dlp
    you-get
    du-dust
    mosh
    python3
    tealdeer
    nil
    nixfmt
    hut
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.helix = { enable = true; };

  programs.bat.enable = true;

  programs.zoxide.enable = true;

}
