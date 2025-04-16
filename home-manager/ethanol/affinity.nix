# Configuration for the affinity ethanol bottles

{ config, pkgs, lib, ... }: {
    options = {
        ethanol-home.affinity.enable = lib.mkEnableOption "affinity photo with ethanol";
    };
 
    config = lib.mkIf config.ethanol-home.affinity.enable {
        programs.ethanol.bottles.affinity = {
            winePackage = pkgs.affinity-wine; # A custom version of wine is needed to run the Affinity suite

            initScript = ''
                #!/usr/bin/env bash
                set -eux
    
                # Prevents wine wineboot from installing mono itself so we can provide our own version
                WINEDLLOVERRIDES="mscore=" wineboot --init
                wine msiexec /i "$winepath/share/wine/mono/wine-mono-9.4.0-x86.msi"

                winetricks -q dotnet48 corefonts mfc140
                wine winecfg -v win11
            '';

            runScript = ''
                #!/usr/bin/env bash
                set -eux

                # Make desktop icons if they don't exist
                if [[ ! -f $HOME/.local/share/ethanol/icons/affinity-photo.png ]] then
                    wine winemenubuilder -t $HOME/.local/share/ethanol/affinity/bottle/drive_c/users/${config.home.username}/Desktop/Affinity\ Photo\ 2.lnk $HOME/.local/share/ethanol/icons/affinity-photo.png
                fi
    
                if [[ ! -f $HOME/.local/share/ethanol/icons/affinity-designer.png ]] then
                    wine winemenubuilder -t $HOME/.local/share/ethanol/affinity/bottle/drive_c/users/${config.home.username}/Desktop/Affinity\ Designer\ 2.lnk $HOME/.local/share/ethanol/icons/affinity-designer.png
                fi

                # Run programs
                case "$1" in
                    photo)
                        wine "$HOME"/.local/share/ethanol/affinity/bottle/drive_c/Program\ Files/Affinity/Photo\ 2/Photo.exe
                        ;;
                    designer)
                        wine "$HOME"/.local/share/ethanol/affinity/bottle/drive_c/Program\ Files/Affinity/Designer\ 2/Designer.exe
                        ;;
                    *)
                        echo "'$1' is not a valid program."
                        exit 1
                        ;;
                esac
            '';
        };

        xdg.desktopEntries = {
            affinityPhoto = {
                name = "Affinity Photo 2";
                exec = "${pkgs.ethanol}/bin/ethanol run affinity photo";
                type = "Application";
                startupNotify = true;
                icon = "/home/${config.home.username}/.local/share/ethanol/icons/affinity-photo.png";
                settings = {
                    StartupWMClass = "photo.exe";
                };
            };
            affinityDesigner = {
                name = "Affinity Designer 2";
                exec = "${pkgs.ethanol}/bin/ethanol run affinity designer";
                type = "Application";
                startupNotify = true;
                icon = "/home/${config.home.username}/.local/share/ethanol/icons/affinity-designer.png";
                settings = {
                    StartupWMClass = "designer.exe";
                };
            };
        };
    };
}
