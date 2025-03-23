# Configuration for the persistence of files in impermanence setups.
# See https://github.com/nix-community/impermanence for more info.

{ config, lib, ... }: {
    options = {
        persistence.enable = lib.mkEnableOption "persistence of files in an impermanence configuration";
    };

    config = lib.mkIf config.persistence.enable {
        environment.persistence."/pers" = {
            hideMounts = true;
            directories = [
                "/etc/nixos" # NixOS configuration files
                "/var/lib/nixos" # Important NixOS cache

                "/var/log" # System log directory
                "/var/lib/systemd/coredump" # Systemd coredump logs
            ];
        };
    };
}
