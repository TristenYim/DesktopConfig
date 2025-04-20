# TODO: Change pkgs version to one on a stable channel to avoid rebuilding
# on update.

{ pkgs, ... }: {
    nixpkgs.overlays = [(
        final: prev: {
            affinity-wine = pkgs.callPackage ./affinity-wine.nix { };
            ethanol = import ./script.nix { inherit pkgs; };
        }
    )];
}
