{
  pkgs,
  lib,
  theme,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      # meslo-lg
      noto-fonts
      noto-fonts-emoji
      roboto
      # ibm-plex
      iosevka-bin
      (nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka" "NerdFontsSymbolsOnly"];})
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      subpixel = {
        lcdfilter = "none";
        rgba = "none";
      };
      hinting = {
        enable = false;
        autohint = false;
        style = "none";
      };
      defaultFonts = {
        serif = ["Roboto" "Symbols Nerd Font Mono"];
        sansSerif = ["Roboto" "Symbols Nerd Font Mono"];
        monospace = ["Roboto" "Symbols Nerd Font Mono"];
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
      with theme.colors; [
        (substr normal.black)
        (substr normal.red)
        (substr normal.green)
        (substr normal.yellow)
        (substr normal.blue)
        (substr normal.purple)
        (substr normal.cyan)
        (substr normal.gray)
        (substr bright.black)
        (substr bright.red)
        (substr bright.green)
        (substr bright.yellow)
        (substr bright.blue)
        (substr bright.purple)
        (substr bright.cyan)
        (substr bright.gray)
      ];
  };
}
