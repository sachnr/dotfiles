{
  lib,
  pkgs,
  theme,
}: let
  rgb_str = rgb_map: "${rgb_map.r},${rgb_map.g},${rgb_map.b}";
  rgbpallete = let
    split = float: builtins.head (lib.strings.splitString "." float);
    split_all = data: lib.attrsets.mapAttrs (_: value: split (toString value)) data;
  in
    with pkgs.lib.nix-rice; {
      black = split_all (color.hexToRgba theme.colors.normal.black);
      bg = split_all (color.hexToRgba theme.colors.primary.background);
      altbg = split_all (color.hexToRgba theme.colors.primary.background2);
      fg = split_all (color.hexToRgba theme.colors.primary.foreground);
      fginactive = split_all (color.hexToRgba theme.colors.bright.gray);
      green = split_all (color.hexToRgba theme.colors.normal.green);
      brightgreen = split_all (color.hexToRgba theme.colorsbright.green);
      brightred = split_all (color.hexToRgba theme.colors.bright.red);
      orange = split_all (color.hexToRgba theme.colors.bright.red);
    };
in
  with rgbpallete; ''
    [Colors:View]
    BackgroundAlternate=${rgb_str altbg}
    BackgroundNormal=${rgb_str bg}
    DecorationFocus=${rgb_str bg}
    DecorationHover=${rgb_str bg}
    ForegroundActive=${rgb_str bg}
    ForegroundInactive=${rgb_str fginactive}
    ForegroundLink=${rgb_str brightgreen}
    ForegroundNegative=${rgb_str brightred}
    ForegroundNeutral=${rgb_str orange}
    ForegroundNormal=${rgb_str fg}
    ForegroundPositive=${rgb_str green}
    ForegroundVisited=${rgb_str fginactive}

    [KFileDialog Settings]
    Allow Expansion=false
    Automatically select filename extension=true
    Breadcrumb Navigation=true
    Decoration position=2
    LocationCombo Completionmode=5
    PathCombo Completionmode=5
    Show Bookmarks=false
    Show Full Path=false
    Show Inline Previews=true
    Show Preview=false
    Show Speedbar=true
    Show hidden files=true
    Sort by=Name
    Sort directories first=true
    Sort hidden files last=false
    Sort reversed=false
    Speedbar Width=101
    View Style=DetailTree

    [KShortcutsDialog Settings]
    Dialog Size=600,480

    [General]
    TerminalApplication=wezterm
  ''
