{
  pkgs,
  fetchTarball
}: {
  pname,
  version,
  url,
  sha256
}:
pkgs.stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchTarball {
    inherit url sha256;
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/icons/$pname
    cp -a $src/* $out/share/icons/$pname/
  '';
}
