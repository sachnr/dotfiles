{ pkgs, stdenv, lib, glib, libxml2, bc, gtk-engine-murrine, theme, ... }:
let
  getPackage = pname: pkgs:
    (pkgs.callPackage ../_sources/generated.nix { }).${pname};
  oomox-colors = let substr = str: lib.strings.removePrefix "#" str;
  in with theme.colors; ''
    BG=${substr primary.background2}
    FG=${substr primary.foreground}
    SEL_BG=${substr primary.accent}
    SEL_FG=${substr normal.black}
    ACCENT_BG=${substr primary.accent}
    TXT_BG=${substr primary.background2}
    TXT_FG=${substr primary.foreground}
    HDR_BG=${substr primary.background}
    HDR_FG=${substr primary.foreground}
    BTN_BG=${substr primary.background3}
    BTN_FG=${substr primary.foreground}
    HDR_BTN_BG=${substr primary.background3}
    HDR_BTN_FG=${substr primary.foreground}
    WM_BORDER_FOCUS=${substr primary.selection}
    WM_BORDER_UNFOCUS=${substr primary.background3}
    ROUNDNESS=3
    ROUNDNESS_GTK2_HIDPI=3
    OUTLINE_WIDTH=1
    BTN_OUTLINE_OFFSET=-3
    BTN_OUTLINE_WIDTH=1
    SPACING=2
    GRADIENT=0.0
    CINNAMON_OPACITY=1.0
    INACTIVE_FG=${substr primary.foreground}
    INACTIVE_TXT_FG=${substr primary.foreground}
    INACTIVE_HDR_FG=${substr primary.foreground}
    ICONS_ARCHDROID=${substr primary.foreground}
    ICONS_DARK=${substr normal.black}
    ICONS_MEDIUM=${substr normal.black}
    ICONS_LIGHT=${substr primary.accent}
    ICONS_LIGHT_FOLDER=${substr primary.accent}
    ICONS_NUMIX_STYLE=0
    ICONS_STYLE=gnome_colors
    ICONS_SYMBOLIC_ACTION=${substr primary.accent}
    ICONS_SYMBOLIC_PANEL=${substr primary.accent}
    CARET1_FG=${substr bright.gray}
    CARET2_FG=${substr normal.gray}
    CARET_SIZE=0.04
    MENU_BG=${substr primary.background3}
    MENU_FG=${substr primary.foreground}
    OUTLINE_WIDTH=1
    SPOTIFY_PROTO_BG=${substr primary.background3}
    SPOTIFY_PROTO_FG=${substr primary.foreground}
    SPOTIFY_PROTO_SEL=${substr normal.blue}
    SURUPLUS_GRADIENT1=${substr primary.foreground}
    SURUPLUS_GRADIENT2=${substr normal.blue}
    SURUPLUS_GRADIENT_ENABLED=False
    TERMINAL_BASE_TEMPLATE=tempus_summer
    TERMINAL_COLOR0=${substr normal.black}
    TERMINAL_COLOR1=${substr normal.red}
    TERMINAL_COLOR2=${substr normal.green}
    TERMINAL_COLOR3=${substr normal.yellow}
    TERMINAL_COLOR4=${substr normal.blue}
    TERMINAL_COLOR5=${substr normal.purple}
    TERMINAL_COLOR6=${substr normal.cyan}
    TERMINAL_COLOR7=${substr normal.gray}
    TERMINAL_COLOR8=${substr bright.black}
    TERMINAL_COLOR9=${substr bright.red}
    TERMINAL_COLOR10=${substr bright.green}
    TERMINAL_COLOR11=${substr bright.yellow}
    TERMINAL_COLOR12=${substr bright.blue}
    TERMINAL_COLOR13=${substr bright.purple}
    TERMINAL_COLOR14=${substr bright.cyan}
    TERMINAL_COLOR15=${substr bright.gray}
    TERMINAL_FOREGROUND=${substr primary.foreground}
    TERMINAL_BACKGROUND=${substr primary.background}
    TERMINAL_ACCENT_COLOR=${substr primary.selection}
    TERMINAL_THEME_ACCURACY=128
    TERMINAL_THEME_AUTO_BGFG=False
    TERMINAL_THEME_EXTEND_PALETTE=False
    TERMINAL_THEME_MODE=smarty
    BASE16_GENERATE_DARK=False
    BASE16_INVERT_TERMINAL=False
    BASE16_MILD_TERMINAL=False
    UNITY_DEFAULT_LAUNCHER_STYLE=False
  '';
in let package = getPackage "themixgui" pkgs;
in stdenv.mkDerivation {
  name = "oomox-gtk";
  version = package.version;
  src = package.src;

  dontBuild = true;

  nativeBuildInputs = [ glib libxml2 bc ];

  buildInputs = with pkgs; [
    gnome3.gnome-themes-extra
    gdk-pixbuf
    librsvg
    sassc
    inkscape
    optipng
  ];

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  installPhase = ''
    mkdir -p $out/share/icons/icons_papirus
    echo "${oomox-colors}" > $out/oomox.colors
    pushd plugins/icons_papirus
    patchShebangs .
    ./change_color.sh -o icons_papirus -d $out/share/icons/icons_papirus $out/oomox.colors
    popd
    mkdir -p $out/share/themes/numix
    pushd plugins/theme_oomox
    patchShebangs .
    HOME=$out ./change_color.sh -o numix -m all -t $out/share/themes $out/oomox.colors
    popd
  '';

  meta = {
    description = "custom theme utility";
    homepage = "https://github.com/themix-project/themix-gui";
    maintainers = [ ];
  };
}
