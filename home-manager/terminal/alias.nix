{ config, pkgs, lib, ... }: {

    # Set a toggle to enable alias config 
    options = {
        alias-home.enable = lib.mkEnableOption "Enables alias configuration";
    };
 
    config = lib.mkIf config.alias-home.enable 
    {
        home.shellAliases = {
            sudo = "sudo ";
            hms = "home-manager switch --flake $FLAKE --impure";
            nrb = "nixos-rebuild boot --flake $FLAKE";
            nrs = "nixos-rebuild switch --flake $FLAKE";
            nrt = "nixos-rebuild test --flake $FLAKE";
            ngl = "nix-env --list-generations --profile /nix/var/nix/profiles/system";
            ngd = "nix-env --delete-generations --profile /nix/var/nix/profiles/system";
        };
        programs.zsh = {
            initExtra = 
            ''
                function nixShellPackages() {
                    packages=""
                    for package in "$@"; do
                        packages+=" nixpkgs#$package"
                    done
                    eval nix shell --inputs-from $FLAKE $packages
                }
            '';
            shellAliases = {
                ns = "nixShellPackages";
            };
        };
    };
}
