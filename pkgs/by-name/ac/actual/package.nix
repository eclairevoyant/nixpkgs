{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "actual";
  version = "23.11.0";

  src = fetchFromGitHub {
    owner = "actualbudget";
    repo = "actual";
    rev = "v${version}";
    hash = "sha256-4DvdPgWh4tXhSVod2Wp84l7Aqpg3Fv8zpPWawPScjUQ=";
  };

  meta = {
    description = "A local-first personal finance app";
    homepage = "https://github.com/actualbudget/actual";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "actual";
    platforms = lib.platforms.all;
  };
}
