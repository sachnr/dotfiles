{
  pkgs,
  lib,
  theme,
  ...
}: {
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

  console = {
    # keyMap = "us";
    packages = with pkgs; [terminus_font];
    font = "ter-u28b";
    useXkbConfig = true; # use xkbOptions in tty.
    earlySetup = true;
    colors = let
      substr = str: lib.strings.removePrefix "#" str;
    in
      with theme; [
        (substr black)
        (substr red)
        (substr green)
        (substr yellow)
        (substr blue)
        (substr purple)
        (substr aqua)
        (substr gray)
        (substr brightblack)
        (substr brightred)
        (substr brightgreen)
        (substr brightyellow)
        (substr brightblue)
        (substr brightpurple)
        (substr brightaqua)
        (substr brightgray)
      ];
  };
}
