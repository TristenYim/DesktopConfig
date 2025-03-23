{ pkgs, ... }: { 
    nixpkgs.overlays = 
    let
        resize-root = import ./resize-root.nix { inherit pkgs; };
    in
    [(
        final: prev: {
            unchartedScripts = pkgs.symlinkJoin {
                name = "unchartedScripts";
                paths = [ resize-root ];
            };
        }
    )];
}
