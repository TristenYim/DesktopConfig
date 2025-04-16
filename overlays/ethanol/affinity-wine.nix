# This changes the source of the default wine package to ElementalWarrior's fork.
# Inspired by https://github.com/lf-/affinity-crimes

{ wineWow64Packages, runCommandNoCC, fetchFromGitLab }:
let 
    wine = wineWow64Packages.unstableFull.overrideAttrs (prev: {
        # https://gitlab.winehq.org/ElementalWarrior/wine/-/commits/affinity-photo3-wine9.13-part3
        src = fetchFromGitLab {
            domain = "gitlab.winehq.org";
            owner = "elementalwarrior";
            repo = "wine";
            rev = "a7c9b19e1a26cf49c63a7c19189a3e2bbe2c6ac2";
            hash = "sha256-XVhz9p2kgFBoJ376vg8OaFXxcMEjAe9AK1hk0I1rb1Q=";
        };
        version = "9.13";
    });
in
runCommandNoCC "affinity-wine" { inherit wine; } ''
    mkdir -p $out/bin

    for f in $wine/bin/*; do
        ln -s "$f" $out/bin
    done

    # See https://affinity.liz.pet/docs/3-wineprefix_setup.html#setting-up-your-build-and-wineprefix
    ln -s "$wine/bin/wine" $out/bin/wine64

    for dir in include lib share; do
        ln -s "$wine/$dir" $out
    done
''
