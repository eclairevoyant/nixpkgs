{ lib
, stdenv
, fetchFromGitHub
, cmake
, qt6
}:

stdenv.mkDerivation rec {
  pname = "klogg";
  version = "22.06-unstable-2023-08-13";

  src = fetchFromGitHub {
    owner = "variar";
    repo = "klogg";
    rev = "edc7582077ebdadd2825da3fa7b1c2931f816bcf";
    hash = "sha256-27tR3KoBWTnIORDOt0icczHUJ8/h1aWSxyLuAJg+Ag8=";
  };

  nativeBuildInputs = [
    cmake
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
  ];

  /*
CMake Error at /nix/store/mbw6qprvn80p8k7z3lq44hnz6b332xf6-cmake-3.28.3/share/cmake-3.28/Modules/FetchContent.cmake:1667 (message):
  CMake step for simdutf failed: 1
Call Stack (most recent call first):
  /nix/store/mbw6qprvn80p8k7z3lq44hnz6b332xf6-cmake-3.28.3/share/cmake-3.28/Modules/FetchContent.cmake:1819:EVAL:2 (__FetchContent_directPopulate)
  /nix/store/mbw6qprvn80p8k7z3lq44hnz6b332xf6-cmake-3.28.3/share/cmake-3.28/Modules/FetchContent.cmake:1819 (cmake_language)
  cmake/CPM.cmake:1005 (FetchContent_Populate)
  cmake/CPM.cmake:799 (cpm_fetch_package)
  3rdparty/CMakeLists.txt:7 (cpmaddpackage)
*/

  meta = {
    description = "Really fast log explorer based on glogg project";
    homepage = "https://github.com/variar/klogg";
    changelog = "https://github.com/variar/klogg/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ eclairevoyant ];
    mainProgram = "klogg";
    platforms = lib.platforms.all;
  };
}
