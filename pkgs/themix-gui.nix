{
  pkgs,
  stdenv,
  lib,
  glib,
  libxml2,
  bc,
  gtk-engine-murrine,
  theme,
  ...
}: let
  getPackage = pname: pkgs: (pkgs.callPackage ../_sources/generated.nix {}).${pname};
  oomox-colors = let
    substr = str: lib.strings.removePrefix "#" str;
  in
    with theme; ''
      BG=${substr background2}
      FG=${substr foreground}
      SEL_BG=${substr accent}
      SEL_FG=${substr black}
      ACCENT_BG=${substr accent}
      TXT_BG=${substr background2}
      TXT_FG=${substr foreground}
      HDR_BG=${substr background}
      HDR_FG=${substr foreground}
      BTN_BG=${substr background3}
      BTN_FG=${substr foreground}
      HDR_BTN_BG=${substr background3}
      HDR_BTN_FG=${substr foreground}
      WM_BORDER_FOCUS=${substr selection}
      WM_BORDER_UNFOCUS=${substr background3}
      ROUNDNESS=3
      ROUNDNESS_GTK2_HIDPI=3
      OUTLINE_WIDTH=1
      BTN_OUTLINE_OFFSET=-3
      BTN_OUTLINE_WIDTH=1
      SPACING=2
      GRADIENT=0.0
      CINNAMON_OPACITY=1.0
      INACTIVE_FG=${substr foreground}
      INACTIVE_TXT_FG=${substr foreground}
      INACTIVE_HDR_FG=${substr foreground}
      ICONS_ARCHDROID=${substr foreground}
      ICONS_DARK=${substr black}
      ICONS_MEDIUM=${substr black}
      ICONS_LIGHT=${substr accent}
      ICONS_LIGHT_FOLDER=${substr accent}
      ICONS_NUMIX_STYLE=0
      ICONS_STYLE=gnome_colors
      ICONS_SYMBOLIC_ACTION=${substr accent}
      ICONS_SYMBOLIC_PANEL=${substr accent}
      CARET1_FG=${substr brightgray}
      CARET2_FG=${substr gray}
      CARET_SIZE=0.04
      MENU_BG=${substr background3}
      MENU_FG=${substr foreground}
      OUTLINE_WIDTH=1
      SPOTIFY_PROTO_BG=${substr background3}
      SPOTIFY_PROTO_FG=${substr foreground}
      SPOTIFY_PROTO_SEL=${substr blue}
      SURUPLUS_GRADIENT1=${substr foreground}
      SURUPLUS_GRADIENT2=${substr blue}
      SURUPLUS_GRADIENT_ENABLED=False
      TERMINAL_BASE_TEMPLATE=tempus_summer
      TERMINAL_COLOR0=${substr black}
      TERMINAL_COLOR1=${substr red}
      TERMINAL_COLOR2=${substr green}
      TERMINAL_COLOR3=${substr yellow}
      TERMINAL_COLOR4=${substr blue}
      TERMINAL_COLOR5=${substr purple}
      TERMINAL_COLOR6=${substr aqua}
      TERMINAL_COLOR7=${substr gray}
      TERMINAL_COLOR8=${substr brightblack}
      TERMINAL_COLOR9=${substr brightred}
      TERMINAL_COLOR10=${substr brightgreen}
      TERMINAL_COLOR11=${substr brightyellow}
      TERMINAL_COLOR12=${substr brightblue}
      TERMINAL_COLOR13=${substr brightpurple}
      TERMINAL_COLOR14=${substr brightaqua}
      TERMINAL_COLOR15=${substr brightgray}
      TERMINAL_FOREGROUND=${substr foreground}
      TERMINAL_BACKGROUND=${substr background}
      TERMINAL_ACCENT_COLOR=${substr selection}
      TERMINAL_THEME_ACCURACY=128
      TERMINAL_THEME_AUTO_BGFG=False
      TERMINAL_THEME_EXTEND_PALETTE=False
      TERMINAL_THEME_MODE=smarty
      BASE16_GENERATE_DARK=False
      BASE16_INVERT_TERMINAL=False
      BASE16_MILD_TERMINAL=False
      UNITY_DEFAULT_LAUNCHER_STYLE=False
    '';
in let
  package = getPackage "themixgui" pkgs;
in
  stdenv.mkDerivation {
    name = "oomox-gtk";
    version = package.version;
    src = package.src;

    dontBuild = true;

    nativeBuildInputs = [
      glib
      libxml2
      bc
    ];

    buildInputs = with pkgs; [
      gnome3.gnome-themes-extra
      gdk-pixbuf
      librsvg
      sassc
      inkscape
      optipng
    ];

    propagatedUserEnvPkgs = [gtk-engine-murrine];

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
      maintainers = [];
    };
  }
