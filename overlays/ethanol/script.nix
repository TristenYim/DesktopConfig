# Huge credit to Jade for their project "affinity crimes"
# Affinity crimes was the main inspiration for this script
# See their project at https://github.com/lf-/affinity-crimes/

{ pkgs, ... }: pkgs.writeShellScriptBin 
    "ethanol"
    ''
        #!/usr/bin/env bash

        basepath=$HOME/.local/share/ethanol

        exit_if_no_bottle() {
            if [[ ! -f "$basepath/$1/wine.conf" ]] then
                echo "No such bottle exists."
                exit 1
            fi
        }

        mk_icons_folder() {
            if [[ ! -d "$basepath/icons" ]] then
                mkdir "$basepath/icons"
            fi
        }

        export_wine_environment() {
            # Set environment variables based on provided wine package
            winepath="$(awk -F= '{print $2}' "$basepath"/"$1"/wine.conf)"
            bottlepath="$basepath/$1"

            export WINEPREFIX="$bottlepath/bottle"
            export PATH="$winepath/bin:$PATH"
            export LD_LIBRARY_PATH="$winepath/bin:$PATH"
            export WINESERVER="$winepath/bin/wineserver"
            export WINELOADER="$winepath/bin/wine"
            export WINEDLLPATH="$winepath/lib/wine"
        }

        _init() {
            export_wine_environment "$1"

            # Run provided init script
            shift
            source "$bottlepath"/init "$@"

            # Install provided programs
            if [[ -d "$bottlepath/installers" ]] then
                find -L "$bottlepath"/installers -maxdepth 1 -type f -exec wine {} \;
            fi

            # WinMetadata is necessary for many wine apps to run
            ln -s "$basepath"/WinMetadata "$bottlepath"/bottle/drive_c/windows/system32/
        }

        _run() {
            export_wine_environment "$1"

            # Run provided runner script
            shift
            source "$bottlepath"/run "$@"
        }

        _wine() {
            export_wine_environment "$1"

            # Run arbitrary wine command under the right prefix
            shift
            wine "$@"
        }

        set -eux

        exit_if_no_bottle "$2"
        mk_icons_folder

        case "$1" in
            run)
                shift
                _run "$@"
                ;;
            init)
                shift
                _init "$@"
                ;;
            wine)
                shift
                _wine "$@"
                ;;
            *)
                echo "'$1' is not a known subcommand." >&2
                exit 1
                ;;
        esac
    ''
