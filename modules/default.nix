{ config, pkgs, lib, ... }: {

    # Default options are set in each of the submodules, for now
    imports = [
        ./desktop-apps.nix
        ./desktop-environment.nix
        ./nvidia.nix
        ./productivity.nix
        ./system.nix
        ./users.nix
        ./utilities.nix
    ];
}
