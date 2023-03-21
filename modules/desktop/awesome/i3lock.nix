{
  pkgs,
  theme,
}: let
  substr = str: builtins.substring 1 6 str;
in
  with theme.colors;
    pkgs.writeShellScriptBin "i3lockwconfig" ''
      ${pkgs.i3lock-color}/bin/i3lock-color -i ${wallpaper} \
          -ntfe --force-clock --indicator --inside-color=${substr background} \
          --ring-color=${substr foreground} \
          --ringver-color=${substr green} --ringwrong-color=${substr red} \
          --separator-color=${substr brightblack} \
          --ind-pos="x+86:y+1003" --time-pos="x+86:y+940" --date-pos="x+86:y+955" --radius=15 \
          --date-color=${foreground} --time-color=${foreground} \
          --radius=15 --verif-text="" --wrong-text="" --noinput-text=""
    ''
