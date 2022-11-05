{ config, pkgs, ... }: {
  fonts = {
    fonts = with pkgs; [
      sarasa-gothic
      source-han-sans
      source-han-serif
      iosevka
      victor-mono
      emojione
      ibm-plex
      cascadia-code
      fira-code
      recursive
      liberation_ttf
      ubuntu_font_family
      roboto
      lato
    ];
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      monospace = [ "Sarasa Mono SC" ];
      sansSerif = [ "Sarasa UI SC" ];
      serif = [ "Sarasa UI SC" ];
      emoji = [ "EmojiOne Color" ];
    };
  };
}
