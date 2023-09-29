{inputs, ...}: let
  getPackage = pname: pkgs: (pkgs.callPackage ../../_sources/generated.nix {}).${pname};
in
  with inputs; [
    nur.overlay
    # nixpkgs-wayland.overlay
    neovim-nightly-overlay.overlay
    nix-rice.overlays.default
    (import (inputs.lua-extra-pkgs))
    (final: prev: {
      extraLuaPackages.dbus_proxy = prev.extraLuaPackages.dbus_proxy.override {
        lua = prev.luajit;
      };

      extraLuaPackages.pulseaudio_dbus = prev.extraLuaPackages.pulseaudio_dbus.override {
        lua = prev.luajit;
      };

      awesome = let
        package = getPackage "awesomewm" prev;
      in
        (prev.awesome.override {
          lua = prev.luajit;
          gtk3Support = true;
        })
        .overrideAttrs (old: {
          inherit (package) src version;
          patches = [];
          postPatch = ''
            patchShebangs tests/examples/_postprocess.lua
            patchShebangs tests/examples/_postprocess_cleanup.lua
          '';
        });

      picom-git = let
        package = getPackage "picom" prev;
      in (prev.picom.overrideAttrs (old: {
        inherit (package) src version;
        buildInputs =
          (old.buildInputs or [])
          ++ [
            prev.pcre2
            prev.xorg.xcbutil
          ];
      }));

      # sway-unwrapped = nixpkgs-wayland.packages.x86_64-linux.sway-unwrapped.override {
      #   wlroots_0_16 = nixpkgs-wayland.packages.x86_64-linux.wlroots.overrideAttrs (_: {
      #     # patches = (prev.patches or []) ++ [./patches/nvidia.patch];
      #     postPatch = (prev.postPatch or "") + ''substituteInPlace render/gles2/renderer.c --replace "glFlush();" "glFinish();" '';
      #   });
      # };
    })
  ]
