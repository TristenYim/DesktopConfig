{ config, lib, ... }: {
    imports = [
        ./default.nix
    ];

    config = lib.mkIf (!config.isStandalone) {
        nixpkgs.overlays = lib.mkForce null;
    };
}
