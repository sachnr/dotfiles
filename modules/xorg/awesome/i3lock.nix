{ pkgs, theme, }:
let substr = str: builtins.substring 1 6 str;
in with theme.colors;
pkgs.writeShellScriptBin "i3lock-script" ''
  if [ -f "/tmp/i3lock_ss.png" ]; then
      rm "/tmp/i3lock_ss.png"
  fi

  ${pkgs.scrot}/bin/scrot "/tmp/i3lock_ss.png"

  ${pkgs.i3lock-color}/bin/i3lock-color -i "/tmp/i3lock_ss.png" \
      -ntfe --force-clock --indicator --inside-color=${
        substr primary.background
      } \
      --ring-color=${substr primary.foreground} \
      --ringver-color=${substr normal.green} --ringwrong-color=${
        substr normal.red
      } \
      --separator-color=${substr bright.black} \
      --ind-pos="x+960:y+540" --time-pos="x+960:y+540" --date-pos="x+960:y+560" --radius=100 \
      --date-color=${normal.blue} --time-color=${bright.blue} \
      --verif-text="" --wrong-text="" --noinput-text=""
''

# pkgs.writeShellScriptBin "i3lock-script" ''
#   ${pkgs.i3lock-color}/bin/i3lock-color -i ${theme.wallpaper} \
#       -ntfe --force-clock --indicator --inside-color=${
#         substr primary.background
#       } \
#       --ring-color=${substr primary.foreground} \
#       --ringver-color=${substr normal.green} --ringwrong-color=${
#         substr normal.red
#       } \
#       --separator-color=${substr bright.black} \
#       --ind-pos="x+86:y+1003" --time-pos="x+86:y+940" --date-pos="x+86:y+955" --radius=15 \
#       --date-color=${primary.foreground} --time-color=${primary.foreground} \
#       --radius=15 --verif-text="" --wrong-text="" --noinput-text=""
# ''
#
