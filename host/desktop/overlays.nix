{inputs, ...}:
with inputs; [
  nur.overlay
  # nixpkgs-wayland.overlay
  neovim-nightly-overlay.overlay
  nixpkgs-f2k.overlays.compositors
  nix-rice.overlays.default
  (final: prev: {
    awesome = nixpkgs-f2k.packages.x86_64-linux.awesome-luajit-git;
    # sway-unwrapped = nixpkgs-wayland.packages.x86_64-linux.sway-unwrapped.override {
    #   wlroots_0_16 = nixpkgs-wayland.packages.x86_64-linux.wlroots.overrideAttrs (_: {
    #     # patches = (prev.patches or []) ++ [./patches/nvidia.patch];
    #     postPatch = (prev.postPatch or "") + ''substituteInPlace render/gles2/renderer.c --replace "glFlush();" "glFinish();" '';
    #   });
    # };
  })
]
