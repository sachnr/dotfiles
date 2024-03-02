{ pkgs, theme, }:
let substr = str: builtins.substring 1 6 str;
in with theme.colors;
pkgs.writeShellScriptBin "i3lock-script" ''
  ${pkgs.i3lock-color}/bin/i3lock-color -i ${theme.wallpaper} \
      -ntfe --force-clock --indicator --inside-color=${
        substr primary.background
      } \
      --ring-color=${substr primary.foreground} \
      --ringver-color=${substr normal.green} --ringwrong-color=${
        substr normal.red
      } \
      --separator-color=${substr bright.black} \
      --ind-pos="x+86:y+1003" --time-pos="x+86:y+940" --date-pos="x+86:y+955" --radius=15 \
      --date-color=${primary.foreground} --time-color=${primary.foreground} \
      --radius=15 --verif-text="" --wrong-text="" --noinput-text=""
''
