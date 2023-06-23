{pkgs, ...}: {
  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
      iosevka
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
        serif = ["Noto Sans" "Symbols Nerd Font Mono"];
        sansSerif = ["Noto Sans" "Symbols Nerd Font Mono"];
        monospace = ["Noto Monospace" "Symbols Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
