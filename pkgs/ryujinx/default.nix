{
  pkgs ? import <nixpkgs> {system = builtins.currentSystem;},
  lib ? pkgs.lib,
  buildDotnetModule ? pkgs.buildDotnetModule,
  dotnetCorePackages ? pkgs.dotnetCorePackages,
  stdenvNoCC ? pkgs.stdenvNoCC,
  fetchFromGitHub ? pkgs.fetchFromGitHub,
  wrapGAppsHook ? pkgs.wrapGAppsHook,
  libX11 ? pkgs.xorg.libX11,
  libgdiplus ? pkgs.libgdiplus,
  ffmpeg ? pkgs.ffmpeg,
  openal ? pkgs.openal,
  libsoundio ? pkgs.libsoundio,
  sndio ? pkgs.sndio,
  pulseaudio ? pkgs.pulseaudio,
  gtk3 ? pkgs.gtk3,
  gdk-pixbuf ? pkgs.gdk-pixbuf,
  vulkan-loader ? pkgs.vulkan-loader,
  libICE ? pkgs.xorg.libICE,
  libSM ? pkgs.xorg.libSM,
  libXi ? pkgs.xorg.libXi,
  libXcursor ? pkgs.xorg.libXcursor,
  libXext ? pkgs.xorg.libXext,
  libXrandr ? pkgs.xorg.libXrandr,
  fontconfig ? pkgs.fontconfig,
  glew ? pkgs.glew,
  libGL ? pkgs.libGL,
  SDL2 ? pkgs.SDL2,
  SDL2_mixer ? pkgs.SDL2,
}:
buildDotnetModule rec {
  pname = "ryujinx-new";
  version = "1.1.800"; # Based off of the official github actions builds: https://github.com/Ryujinx/Ryujinx/actions/workflows/release.yml

  src = pkgs.fetchFromGitHub {
    owner = "Ryujinx";
    repo = "Ryujinx";
    rev = "1.1.800";
    sha256 = "sha256-ip07p6C9qmWPI7I+wK20AgEkeRNLIgecNRAaVklI+oA=";
  };

  dotnet-sdk = pkgs.dotnet-sdk_7;
  dotnet-runtime = pkgs.dotnet-runtime_7;

  nugetDeps = ./deps.nix;

  nativeBuildInputs = [
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    gdk-pixbuf
  ];

  runtimeDeps = [
    gtk3
    libX11
    libgdiplus
    SDL2_mixer
    openal
    libsoundio
    sndio
    pulseaudio
    vulkan-loader
    ffmpeg

    # Avalonia UI
    libICE
    libSM
    libXi
    libXcursor
    libXext
    libXrandr
    fontconfig
    glew

    # Headless executable
    libGL
    SDL2
  ];

  projectFile = "Ryujinx.sln";
  testProjectFile = "src/Ryujinx.Tests/Ryujinx.Tests.csproj";
  doCheck = true;

  dotnetFlags = [
    "/p:ExtraDefineConstants=DISABLE_UPDATER%2CFORCE_EXTERNAL_BASE_DIR"
  ];

  executables = [
    "Ryujinx.Headless.SDL2"
    "Ryujinx.Ava"
    "Ryujinx"
  ];

  makeWrapperArgs = [
    # Without this Ryujinx fails to start on wayland. See https://github.com/Ryujinx/Ryujinx/issues/2714
    "--set GDK_BACKEND x11"
    "--set SDL_VIDEODRIVER x11"
  ];

  preInstall = ''
    # workaround for https://github.com/Ryujinx/Ryujinx/issues/2349
    mkdir -p $out/lib/sndio-6
    ln -s ${sndio}/lib/libsndio.so $out/lib/sndio-6/libsndio.so.6
  '';

  preFixup = ''
    mkdir -p $out/share/{applications,icons/hicolor/scalable/apps,mime/packages}
    pushd ${src}/distribution/linux

    install -D ./Ryujinx.desktop $out/share/applications/Ryujinx.desktop
    install -D ./mime/Ryujinx.xml $out/share/mime/packages/Ryujinx.xml
    install -D ../misc/Logo.svg $out/share/icons/hicolor/scalable/apps/Ryujinx.svg

    substituteInPlace $out/share/applications/Ryujinx.desktop \
      --replace "Exec=Ryujinx" "Exec=$out/bin/Ryujinx"

    ln -s $out/bin/Ryujinx $out/bin/ryujinx

    popd
  '';

  meta = with lib; {
    homepage = "https://ryujinx.org/";
    changelog = "https://github.com/Ryujinx/Ryujinx/wiki/Changelog";
    description = "Experimental Nintendo Switch Emulator written in C#";
    longDescription = ''
      Ryujinx is an open-source Nintendo Switch emulator, created by gdkchan,
      written in C#. This emulator aims at providing excellent accuracy and
      performance, a user-friendly interface and consistent builds. It was
      written from scratch and development on the project began in September
      2017.
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ivar jk];
    platforms = ["x86_64-linux"];
    mainProgram = "Ryujinx";
  };
}
