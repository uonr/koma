{ pkgs, ... }:
let
  vim-chinese-document = pkgs.vimUtils.buildVimPlugin {
    name = "vimcdoc";
    pname = "vimcdoc";
    src = pkgs.fetchFromGitHub {
      owner = "yianwillis";
      repo = "vimcdoc";
      rev = "c0d3edb1de4bd83df08e99c5f63393069a17f066";
      sha256 = "blUAz0JDG6ts5WLDogHMTdnE/RgUu9QEeeT9xjm3TJI=";
    };
  };
  neovim-beacon = pkgs.vimUtils.buildVimPlugin {
    name = "beacon-nvim";
    pname = "beacon-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "rainbowhxch";
      repo = "beacon.nvim";
      rev = "f44c49fd72217fc2fc065a99fe90d36436dae2f3";
      sha256 = "kcjOLjY/+5p3cYSpWTK8i0u69MhgCvvNVB6zDFHjcjI=";
    };
  };
  plugins = with pkgs.vimPlugins; [
    nvim-autopairs
    editorconfig-vim
    vim-airline
    vim-airline-themes
    vim-surround
    vim-chinese-document
    vim-easymotion
    vim-fish
    gruvbox
    vim-repeat
    vim-sleuth
    vim-nix
    indent-blankline-nvim-lua
    vim-commentary
    neovim-beacon
  ];
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = plugins;
  };
}
