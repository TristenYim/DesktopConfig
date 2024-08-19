{ config, pkgs, lib, ... }: {

    # Default options are set in each of the submodules, for now
    imports = [
        ./desktop-environment.nix
        ./nvidia.nix
        ./system.nix
        ./users.nix
        ./utilities.nix
    ];
}
