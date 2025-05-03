# This is a custom function library, similar to nixpkgs lib.
# The reason why I'm doing it this way instead of extending lib is lib cannot 
# reference config (it will throw an infinite recursion error).

# Later, I may merge things such as nixGLWrap and catppuccin colors into this.

{ config, lib }:
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
in
{
    home = rec {
        # Since options with many arguments are really just nested functions,
        # it's possible to "partially" evaluate functions like this.
        mkPkgsModule = baseMkPackagesModule "home" "packages";
        mkPkgModule = package: mkPkgsModule [ package ];

        # Persists the given files or directories if the given option
        # and persistence is enabled.
        persistIf = optionName: directories: files: 
            lib.mkIf (config.apeiron.${optionName}.enable && config.apeiron.persistence.enable) {
                home.persistence."/pers/${config.home.homeDirectory}" = {
                    directories = directories;
                    files = files;
                };
            };

        # Persists each list of files and directories when its corresponding
        # option is enabled. This is just wrapping multiple calls of
        # persistIf into a merged attribute set, where each element of the 
        # argument list is a list containing the arguments for persistIf.
        persistEachIf = persistIfArgList:
            lib.mkMerge ( builtins.map ( persistIfArgs:
                persistIf (builtins.elemAt persistIfArgs 0) (builtins.elemAt persistIfArgs 1) (builtins.elemAt persistIfArgs 2)
            ) persistIfArgList);
    };
    nixos = rec {
        mkPkgsModule = baseMkPackagesModule "environment" "systemPackages";
        mkPkgModule = package: mkPkgsModule [ package ];

        persistIf = optionName: directories: files: 
            lib.mkIf (config.apeiron.${optionName}.enable && config.apeiron.persistence.enable) {
                environment.persistence."/pers" = {
                    directories = directories;
                    files = files;
                };
            };
    };

}
