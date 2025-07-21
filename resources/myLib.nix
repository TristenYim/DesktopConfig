# This is a custom function library, similar to nixpkgs lib.
# The reason why I'm doing it this way instead of extending lib is lib cannot 
# reference config (it will throw an infinite recursion error).

# Later, I may merge things such as nixGLWrap and catppuccin colors into this.

{ lib }:
let
    # Creates a module with an option to conditionally enable the
    # provided packages. The option is named based on optionNamePart,
    # following the format config.apeiron.[optionNamePart].enable.

    # Note this function isn't meant to be called externally, just
    # to share code between home/nixos.mkPkgsModule.

    baseMkPackagesModule = configAttrset: packageListOption: packages: optionNamePart:
        { config, lib, ... }: {
            options.apeiron = lib.setAttrByPath optionNamePart { enable = lib.mkEnableOption "adding the ${lib.lists.last optionNamePart} package to ${configAttrset}.${packageListOption}"; };
            config.${configAttrset}.${packageListOption} = lib.mkIf (lib.getAttrFromPath (optionNamePart ++ [ "enable" ]) config.apeiron) packages;
        };

    # Creates a module with an option to conditionally persist the provided
    # directories and files. This option is enabled by default, but the config
    # is only active if persistence is enabled globally and the module is
    # enabled. The option name is based on optionNamePart, following the 
    # format config.apeiron.[optionName].persist
    baseMkPersistenceModule = config: configAttrset: persistentRoot: directories: files: optionNamePart: { 
        options.apeiron = lib.setAttrByPath optionNamePart { 
            persist = lib.mkOption { 
                default = true; 
                example = false; 
                description = "Whether to enable persistence of files related to ${lib.lists.last optionNamePart}.";
                type = lib.types.bool; 
            }; 
        };
        config.${configAttrset}.persistence.${persistentRoot} = lib.mkIf (
            config.apeiron.persistence.enable && 
            (lib.getAttrFromPath (optionNamePart ++ [ "enable" ]) config.apeiron) && 
            (lib.getAttrFromPath (optionNamePart ++ [ "persist" ]) config.apeiron)
        ) {
            inherit directories files;
        };
    };
in
{
    # Call function f with each list of arguments in argLists.
    mapCalls = f: argLists: 
        builtins.map ( argList: 
            let
                len = builtins.length argList;
                callWithList = n: f: if n == len then f else callWithList (n + 1) (f (builtins.elemAt argList n));
            in
            callWithList 0 (f)
        ) argLists;

    # Utility functions to map keybinds defined in a custom
    # format to program configurations.
    keybinds = let
        modList = [ "SUPER" "SHIFT" "ALT" ];
    in {
        toHyprConf = keys: action: 
            let 
                convertList = separator: i:
                    let
                        e = builtins.elemAt keys i;
                    in if ! builtins.elem e modList then ", ${e}, " else " ${e}" + convertList "_" (i + 1);
            in (convertList "" 0) + action;
        toXfConf = keys: action:
            let
                convertList = i:
                    let
                        e = builtins.elemAt keys i;
                    in if ! builtins.elem e modList then lib.toLower e else "<${e}>" + convertList (i + 1);
            in { "commands/custom/${convertList 0}" = action; };
    };

    home = rec {
        # Since options with many arguments are really just nested functions,
        # it's possible to "partially" evaluate functions like this.
        mkPkgsModule = baseMkPackagesModule "home" "packages";
        mkPkgModule = package: mkPkgsModule [ package ];

        mkPersistenceModule = directories: files: optionNamePart: { config, ... }: baseMkPersistenceModule config "home" "/pers/${config.home.homeDirectory}" directories files optionNamePart;
    };

    nixos = rec {
        mkPkgsModule = baseMkPackagesModule "environment" "systemPackages";
        mkPkgModule = package: mkPkgsModule [ package ];

        mkPersistenceModule = directories: files: optionNamePart: { config, ... }: baseMkPersistenceModule config "environment" "/pers" directories files optionNamePart;
    };
}
