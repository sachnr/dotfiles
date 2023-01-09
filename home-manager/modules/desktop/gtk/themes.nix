{
  lib,
  stdenv,
  fetchurl,
  unzip,
  gnome-themes-extra,
  gtk-engine-murrine,
  gtk_engines,
}:
stdenv.mkDerivation rec {
  pname = "gtk-themes";
  version = "2022";

  srcs = [
    (fetchurl {
      url = "https://github.com/gvolpe/Juno/releases/download/${version}/Juno.tar.xz";
      sha256 = "1cghsn9qagcf1nlga5cal0aqch6hkjm5wk6ja791zxhdqy3crx1i";
    })
  ];

  nativeBuildInputs = [unzip];

  buildInputs = [
    gnome-themes-extra
    gtk_engines
  ];

  propagatedUserEnvPkgs = [gtk-engine-murrine];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    cp -a * $out/share/themes
    rm $out/share/themes/*/{LICENSE,README.md}
    runHook postInstall
  '';
}
