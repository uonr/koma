{ ... }: {
  programs.starship = {
    enable = true;
    settings = {
      rust = { symbol = "𝓡 "; };
      nix_shell = {
        symbol = "❆ ";
        disabled = true;
      };
      lua = { symbol = "☽"; };
      nodejs = {
        symbol = "⬢ ";
        disabled = true;
      };
      python = { symbol = "Py "; };
      directory = {
        read_only = " [RO]";
        read_only_style = "yellow";
      };
      terraform = { disabled = true; };
      battery = {
        full_symbol = "满 ";
        charging_symbol = "输 ";
        discharging_symbol = "断 ";
        unknown_symbol = "电 ";
        empty_symbol = "乏 ";
      };
      package.disabled = true;
    };
  };
}
