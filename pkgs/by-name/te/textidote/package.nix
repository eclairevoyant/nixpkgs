{ lib
, stdenv
, fetchFromGitHub
, jdk
, makeBinaryWrapper
, jre
, ant
, tree
}:

stdenv.mkDerivation {
  pname = "textidote";
  version = "unstable-2023-11-07";

  src = fetchFromGitHub {
    owner = "sylvainhalle";
    repo = "textidote";
    rev = "ad98a18bbb97d1e87297fc66666959d3b91859c7";
    hash = "sha256-5rXxNyd7AtSuXuWY/wwFZGBUEGFAOrCx7YD0yr755y8=";
  };

  nativeBuildInputs = [ ant jdk makeBinaryWrapper ];

  buildPhase = ''
    runHook preBuild

    ant

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    ${lib.getExe tree}

    mkdir -p $out/bin
    makeWrapper ${lib.getExe jre} $out/bin/foo \
      --add-flags "-cp $out/share/java/foo.jar org.foo.Main"

    runHook postInstall
  '';

  meta = {
    description = "Spelling, grammar and style checking on LaTeX documents";
    homepage = "https://sylvainhalle.github.io/textidote/";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ eclairevoyant ];
    mainProgram = "textidote";
    platforms = lib.platforms.all;
  };
}
