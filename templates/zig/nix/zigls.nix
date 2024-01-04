{
  inputs,
  system,
  pkgs,
}: let
  zig = inputs.zig.packages.${system}.master;
in
  pkgs.zls.overrideAttrs (prev: {
    src = inputs.zigls;
    version = "master";
    buildPhase = ''
      mkdir -p .cache
      ln -s ${pkgs.callPackage ./deps.nix {}} .cache/p
      zig build install --cache-dir $(pwd)/zig-cache --global-cache-dir $(pwd)/.cache -Dversion_data_path=$langref -Dcpu=baseline -Doptimize=ReleaseSafe --prefix $out
    '';
    postPatch = [];
    dontConfigure = true;
    dontInstall = true;
    doCheck = true;
    checkPhase = ''
      zig build test --cache-dir $(pwd)/zig-cache --global-cache-dir $(pwd)/.cache -Dversion_data_path=$langref -Dcpu=baseline
    '';
    langref = inputs.langref;
    nativeBuildInputs = [zig];
  })
