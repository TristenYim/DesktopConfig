# This customizable module allows custom wine bottles to be easily 
# added to ethanol and customized.

{ config, pkgs, lib, ... }: 
let
    cfg = config.programs.ethanol;

    # Defines options for wine bottles in ethanol
    bottleType = lib.types.submodule {
        options = {
            enable = lib.mkEnableOption "this bottle in ethanol.";
            winePackage = lib.mkPackageOption pkgs "wineWowPackages.unstableFull" { };
            initScript = lib.mkOption {
                type = lib.types.lines;
                default = "";
                description = "Content of the initialization script of this bottle.";
            };
            runScript = lib.mkOption {
                type = lib.types.lines;
                default = "";
                description = "Content of the run script of this bottle.";
            };
        };
    };
in
{
    options.programs.ethanol = {
        enable = lib.mkEnableOption "ethanol.";
        package = lib.mkPackageOption pkgs "ethanol" { };

        # Allows specifying multiple wine bottles
        bottles = lib.mkOption {
            type = lib.types.attrsOf bottleType;
            default = { };
            description = "Bottles to include in the ethanol directory.";
        };
    };

    config = lib.mkIf cfg.enable {
        home = {
            packages = [ 
                cfg.package
                pkgs.winetricks
            ];

            # All state created by ethanol is stored in $HOME/.local/share/ethanol
            # to keep everything together for impermanence configurations.
            file = (lib.mapAttrs' (name: value:
                lib.nameValuePair ".local/share/ethanol/${name}/init" {
                    text = value.initScript;
                    executable = true;
                }
            ) cfg.bottles)
            // (lib.mapAttrs' (name: value:
                lib.nameValuePair ".local/share/ethanol/${name}/run" {
                    text = value.runScript;
                    executable = true;
                }
            ) cfg.bottles)
            // (lib.mapAttrs' (name: value:
                lib.nameValuePair ".local/share/ethanol/${name}/wine.conf" {
                    text = "path=${value.winePackage}";
                }
            ) cfg.bottles);
        };
    };
}
