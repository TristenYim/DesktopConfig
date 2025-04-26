{ config, lib, ... }: {
    imports = [
        ./default.nix
    ];

    config = lib.mkIf (!config.apeiron.isStandalone) {
        nixpkgs.overlays = lib.mkForce null;
    };
}
