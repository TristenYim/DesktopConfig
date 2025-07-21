{ ... }:

{
    imports = [
        ./tdoggy-default.nix
    ];

    config = {
        # Enable custom module options
        apeiron = {
            terminal.neofetch.enable = true;
            persistence.enable = true;
            isStandalone = false;

            ethanol.enable = true;
        };

        programs.ethanol.bottles.default = {
            runScript = ''
                #!/usr/bin/env bash
                set -eux

                # Run programs
                case "$1" in
                    fnaf-world)
                        wine "$HOME"/.local/share/ethanol/default/bottle/drive_c/Program\ Files/MMFApplications/fnaf-world.exe
                        ;;
                    fnaf-world-qol)
                        wine "$HOME"/.local/share/ethanol/default/bottle/drive_c/Program\ Files/MMFApplications/fnaf-world-qol-v1.14.exe
                        ;;
                    *)
                        echo "'$1' is not a valid program."
                        exit 1
                        ;;
                esac
            '';
        };

        home.sessionVariables = {
            FLAKE = "/etc/nixos";
        };

        home.persistence."/pers/home/tdoggy".files = [ ".nvidia-settings-rc" ];
    };
}
