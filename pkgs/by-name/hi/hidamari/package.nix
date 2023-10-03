{ lib
, stdenv
, fetchFromGitHub
, appstream-glib
, desktop-file-utils
, gettext
, glib
, gtk4
, meson
, ninja
, pkg-config
, python3
, yt-dlp
, makeWrapper
}:

#stdenv.mkDerivation rec {
python3.pkgs.buildPythonPackage rec {
  pname = "hidamari";
  version = "3.3";

  src = fetchFromGitHub {
    owner = "jeffshee";
    repo = "hidamari";
    rev = "v${version}";
    hash = "sha256-0arUA89NgyhMo0kv+zc/GjCHhD+14Qi6KUDVRS4ok2g=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    appstream-glib
    desktop-file-utils
    gettext
    glib
    gtk4
    meson
    ninja
    pkg-config
    yt-dlp
    makeWrapper
  ];

  format = "other";
  pythonPath = [
   (python3.withPackages (ps: with ps; [
      pygobject3
      pillow
      pydbus
      python-vlc
    ]))
  ];

  buildInputs = pythonPath;

  meta = {
    description = "Video wallpaper for Linux";
    homepage = "https://github.com/jeffshee/hidamari";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ eclairevoyant ];
    mainProgram = "hidamari";
    platforms = lib.platforms.all;
  };
}
