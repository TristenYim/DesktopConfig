{ config, pkgs, lib, ... }: {

    # Set a toggle to enable alias config 
    options = {
        alias-home.enable = lib.mkEnableOption "Enables alias configuration";
    };
 
    config = lib.mkIf config.alias-home.enable 
    {
        home.shellAliases = {
            sudo = "sudo ";
            hms = "home-manager switch --flake ~/nix --impure";
            nrb = "nixos-rebuild boot --flake /etc/nixos";
            nrs = "nixos-rebuild switch --flake /etc/nixos";
            nrt = "nixos-rebuild test --flake /etc/nixos";
            nlgen = "nix-env --list-generations --profile /nix/var/nix/profiles/system";
            ndgen = "nix-env --delete-generations --profile /nix/var/nix/profiles/system";
        };
    };
}
