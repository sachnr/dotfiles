{
  pkgs,
  config,
  ...
}: {
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      material-icons
      material-design-icons
      roboto
      (nerdfonts.override {fonts = ["JetBrainsMono" "RobotoMono"];})
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      subpixel.lcdfilter = "default";
      hinting = {
        enable = true;
        autohint = true;
        style = "hintslight";
      };
      defaultFonts = {
        serif = ["Noto Sans" "Roboto" "RobotoMono Nerd Font"];
        sansSerif = ["Noto Sans" "Roboto" "RobotoMono Nerd Font"];
        monospace = ["Noto Monospace" "RobotoMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}