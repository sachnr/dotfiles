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
      maple-mono
      cascadia-code
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
        serif = ["Roboto" "Symbols Nerd Font Mono"];
        sansSerif = ["Roboto" "Symbols Nerd Font Mono"];
        monospace = ["jetBrains Mono" "Symbols Nerd Font Mono"];
        emoji = ["Noto Color Emoji" "Symbols Nerd Font Mono"];
      };
    };
  };
}
