{ pkgs, ... }: {
    nixpkgs.overlays = [(
        final: prev: {
            affinity-wine = pkgs.callPackage ./affinity-wine.nix { };
            ethanol = import ./script.nix { inherit pkgs; };
        }
    )];
}
