{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:
stdenv.mkDerivation {
  pname = "rtl8814au";
  version = "${kernel.version}-unstable-2022-08-18";

  src = fetchFromGitHub {
    owner = "aircrack-ng";
    repo = "rtl8812au";
    rev = "08589e2f8c18d4de18a28d92c74d0a2191bb86b9";
    hash = "sha256-+pgo3V2cJVrMKCqMtuQn3O5CsLe21Nb5RafUyYry0R8=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;
  makeFlags = kernel.makeFlags;

  hardeningDisable = ["pic"];

  NIX_CFLAGS_COMPILE = "-Wno-error=incompatible-pointer-types";

  prePatch = ''
    substituteInPlace ./Makefile \
      --replace /lib/modules/ "${kernel.dev}/lib/modules/" \
      --replace '$(shell uname -r)' "${kernel.modDirVersion}" \
      --replace /sbin/depmod \# \
      --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "RTL8812AU/21AU and RTL8814AU Wireless drivers";
    homepage = "https://github.com/aircrack-ng/rtl8812au";
    license = licenses.gpl2Only;
  };
}
