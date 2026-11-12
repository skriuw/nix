{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  wrapGAppsHook3,
  glib-networking,
  gtk3,
  libsoup_3,
  webkitgtk_4_1,
}:

let
  release = builtins.fromJSON (builtins.readFile ./release.json);
in
stdenv.mkDerivation {
  pname = "skriuw";
  inherit (release) version;

  src = fetchurl {
    url = "https://github.com/remcostoeten/skriuw/releases/download/${release.tag}/Skriuw_${release.version}_amd64.deb";
    inherit (release) sha256;
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    wrapGAppsHook3
  ];

  buildInputs = [
    glib-networking
    gtk3
    libsoup_3
    webkitgtk_4_1
  ];

  sourceRoot = ".";

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r usr/bin usr/share $out/
    runHook postInstall
  '';

  meta = {
    description = "A quiet writing workspace for notes, journaling, sharing, and planning";
    homepage = "https://skriuw.com";
    license = lib.licenses.mit;
    mainProgram = "skriuw-app";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
