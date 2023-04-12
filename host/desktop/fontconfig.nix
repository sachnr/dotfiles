{
  pkgs,
  config,
  ...
}: {
  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
      roboto
      (nerdfonts.override {fonts = ["RobotoMono" "NerdFontsSymbolsOnly"];})
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
      hinting = {
        enable = true;
        autohint = false;
        style = "hintslight";
      };
      defaultFonts = {
        serif = ["Roboto"];
        sansSerif = ["Roboto"];
        monospace = ["RobotoMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
