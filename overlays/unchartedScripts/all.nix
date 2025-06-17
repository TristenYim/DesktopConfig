{ pkgs, ... }: { 
    nixpkgs.overlays = 
    let
        resize-root = import ./resize-root.nix { inherit pkgs; };
        nix-find-impermanent = import ./nix-find-impermanent.nix { inherit pkgs; };
        nix-shell-from-nixpkgs = import ./nix-shell-from-nixpkgs.nix { inherit pkgs; };
    in
    [(
        final: prev: {
            unchartedScripts = pkgs.symlinkJoin {
                name = "unchartedScripts";
                paths = [ resize-root nix-find-impermanent nix-shell-from-nixpkgs ];
            };
        }
    )];
}
