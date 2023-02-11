{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  libxkbcommon,
  lz4,
}:
rustPlatform.buildRustPackage rec {
  pname = "swww";
  version = "v0.7.1";

  src = fetchFromGitHub {
    owner = "Horus645";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-Z90Zwjqcu0hbtJwKPUNV996mtdgX//ZWWm+Dya/JV9A=";
  };

  cargoHash = "sha256-f6++5DazCqJjRuZquiJ5hdf9l+q6sOBZOL/vyQy1hA0=";

  buildInputs = [libxkbcommon lz4];

  nativeBuildInputs = [pkg-config];

  doCheck = false;

  meta = with lib; {
    description = "A Solution to your Wayland Wallpaper Woes";
    homepage = "https://github.com/Horus645/swww";
    license = licenses.gpl3;
    # maintainers = [ maintainers.tailhook ];
  };
}
