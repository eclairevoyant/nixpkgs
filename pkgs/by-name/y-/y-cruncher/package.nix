{
  lib,
  stdenv,
  fetchzip,
  nix-update-script,
  testers,
  tbb,
  numactl,
  makeWrapper,
  autoPatchelfHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "y-cruncher";
  version = "0.8.5.9542";

  src = fetchzip {
    url = "https://github.com/Mysticial/y-cruncher/releases/download/v${finalAttrs.version}/y-cruncher.v${finalAttrs.version}-dynamic.tar.xz";
    hash = "sha256-HweRlBi/7N53Uo2NapP/vr6oer7YPgKzAAf6+DLli20=";
  };

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
  ];

  patchPhase = ''
    runHook prePatch

    mv "Binaries/Digits/Gamma(⅓).txt" "Binaries/Digits/Gamma(1-3).txt"
    mv "Binaries/Digits/Gamma(¼).txt" "Binaries/Digits/Gamma(1-4).txt"

    runHook postPatch
  '';

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,libexec,share}
    cp -r "Custom Formulas" -t $out/share
    cp -r y-cruncher Binaries -t $out/libexec
    ln -s $out/libexec/y-cruncher $out/bin/y-cruncher

    runHook postInstall
  '';

  buildInputs = [
    numactl
    stdenv.cc.cc.lib
    tbb
  ];

  passthru = {
    tests.version = testers.testVersion {
      package = finalAttrs.finalPackage;
      # program will error due to runtime perms, so we ignore the return code
      command = "${finalAttrs.meta.mainProgram} | sed 's_ Build _._' || exit 0";
    };
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Multi-threaded benchmarking program to compute digits of mathematical constants";
    changelog = "https://github.com/Mysticial/y-cruncher/releases/tag/v${finalAttrs.version}";
    homepage = "http://numberworld.org/y-cruncher/";
    license = lib.licenses.unfreeRedistributable // {
      url = "http://numberworld.org/y-cruncher/license.html";
    };
    maintainers = with lib.maintainers; [ eclairevoyant ];
    mainProgram = "y-cruncher";
    platforms = lib.platforms.all;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
