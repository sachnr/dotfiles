{
  pkgs,
  lib,
  config,
  ...
}: let
  startpage = pkgs.callPackage ../../../../pkgs/startpage.nix {};
in {
  home.file = {
    ".config/startpage" = {
      source = startpage;
      recursive = true;
    };
  };
}
