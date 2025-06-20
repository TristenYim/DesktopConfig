{ ... }: {
    nixpkgs.overlays = [
        (final: prev: {
            merienda = final.stdenvNoCC.mkDerivation {
                pname = "merienda";
                version = "1.0"; # Will not build unless a version is specified, even though it is not applicable here

                src = final.fetchFromGitHub {
                    owner = "etunni";
                    repo = "merienda";
                    rev = "15f2f36d29595fa3dd6cf068323ef44bc0713b56";
                    hash = "sha256-pSU772qQTXfTg+rZd0fNUZdpDU0DbP/qwHxqhhBvYOE=";
                };

                installPhase = ''
                    runHook preInstall
                    install -Dm644 -t $out/share/fonts/truetype $src/fonts/ttf/*.ttf
                    runHook postInstall
                '';
            };
        })
    ];
}
