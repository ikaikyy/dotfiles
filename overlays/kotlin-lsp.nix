final: prev: {
  kotlin-lsp = prev.stdenv.mkDerivation rec {
    pname = "kotlin-lsp";
    version = "0.253.10629";

    src = prev.fetchzip {
      url = "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-${version}.zip";
      sha256 = "sha256-LCLGo3Q8/4TYI7z50UdXAbtPNgzFYtmUY/kzo2JCln0=";
      stripRoot = false;
    };

    buildInputs = [prev.jdk17];

    nativeBuildInputs = [
      prev.makeWrapper
    ];

    installPhase = ''
      set -e

      mkdir -p $out/lib/${pname}
      cp -r ./* $out/lib/${pname}
      install -Dm755 $out/lib/${pname}/kotlin-lsp.sh $out/lib/${pname}/kotlin-lsp
      makeWrapper $out/lib/${pname}/kotlin-lsp $out/bin/kotlin-lsp \
        --prefix PATH : '${prev.lib.makeBinPath buildInputs}'
    '';

    dontBuild = true;
  };
}
