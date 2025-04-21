# TODO: Change pkgs version to one on a stable channel to avoid rebuilding
# on update.

{ pkgs, pkgs-stable, ... }: {
    nixpkgs.overlays = [(
        final: prev: {
            affinity-wine = pkgs-stable.callPackage ./affinity-wine.nix { };
            ethanol = import ./script.nix { inherit pkgs; };
        }
    )];
}
