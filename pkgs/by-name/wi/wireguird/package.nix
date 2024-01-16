{ lib
, buildGoModule
, fetchFromGitHub
, pkg-config
, wrapGAppsHook
, libayatana-appindicator
, gtk3
}:

buildGoModule rec {
  pname = "wireguird";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "UnnoTed";
    repo = "wireguird";
    rev = "v${version}";
    hash = "sha256-iv0/HSu/6IOVmRZcyCazLdJyyBsu5PyTajLubk0speI=";
  };

  vendorHash = "sha256-/MeaomhmQL3YNrR4a0ihGwZAo5Zk8snpJvCSXY93aM8=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    libayatana-appindicator
  ];

  ldflags = [ "-s" "-w" ];

  # vendor/golang.org/x/sys/unix/syscall.go:83:16: unsafe.Slice requires go1.17 or later (-lang was set to go1.16; check go.mod)

  meta = {
    description = "Wireguard gtk gui for linux";
    homepage = "https://github.com/UnnoTed/wireguird";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ eclairevoyant ];
    mainProgram = "wireguird";
    platforms = lib.platforms.linux;
  };
}
