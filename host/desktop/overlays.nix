{inputs, ...}: let
  getPackage = pname: pkgs: (pkgs.callPackage ../../_sources/generated.nix {}).${pname};
in
  with inputs; [
    nur.overlay
    nixpkgs-wayland.overlay
    neovim-nightly-overlay.overlay
    nix-rice.overlays.default
    (final: prev: {
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

      wezterm-git = let
        package = getPackage "wezterm" prev;
      in (prev.callPackage "${inputs.nixpkgs}/pkgs/applications/terminal-emulators/wezterm" {
        inherit (prev.darwin.apple_sdk.frameworks) Cocoa CoreGraphics Foundation System UserNotifications;

        rustPlatform =
          prev.rustPlatform
          // {
            buildRustPackage = args:
              prev.rustPlatform.buildRustPackage (args
                // rec {
                  inherit (package) src version;
                  cargoLock = {
                    lockFile = "${src}/Cargo.lock";

                    outputHashes = {
                      "xcb-1.2.1" = "sha256-zkuW5ATix3WXBAj2hzum1MJ5JTX3+uVQ01R1vL6F1rY=";
                      "xcb-imdkit-0.2.0" = "sha256-L+NKD0rsCk9bFABQF4FZi9YoqBHr4VAZeKAWgsaAegw=";
                    };
                  };
                });
          };
      });

      # sway-unwrapped = nixpkgs-wayland.packages.x86_64-linux.sway-unwrapped.override {
      #   wlroots_0_16 = nixpkgs-wayland.packages.x86_64-linux.wlroots.overrideAttrs (_: {
      #     # patches = (prev.patches or []) ++ [./patches/nvidia.patch];
      #     postPatch = (prev.postPatch or "") + ''substituteInPlace render/gles2/renderer.c --replace "glFlush();" "glFinish();" '';
      #   });
      # };
    })
  ]
