# This is a custom function library, similar to nixpkgs lib.
# The reason why I'm doing it this way instead of extending lib is lib cannot 
# reference config (it will throw an infinite recursion error).

# Later, I may merge things such as nixGLWrap and catppuccin colors into this.

{ config, lib }:

{
    home = rec {
        # Adds a set of packages when an enable option is true.
        # Common prefixes and suffixes need not be included, just the
        # option name as a string.
        enablePkgsWith = packageList: optionName:
            lib.mkIf config.apeiron.${optionName}.enable { 
                home.packages = packageList; 
            };

        # Enables a single package when an option name is true.
        enablePkgWith = package: optionName:
            enablePkgsWith [ package ] optionName;

        # Enables each package when its corresponding option is enabled.
        # This is just wrapping multiple calls of persistIf into a 
        # merged attribute set, where each element of the argument list 
        # is a list containing the arguments for enablePkgWith.
        enableEachPkgWith = enablePkgWithArgList:
            lib.mkMerge ( builtins.map ( enablePkgWithArgs:
                enablePkgWith (builtins.elemAt enablePkgWithArgs 0) (builtins.elemAt enablePkgWithArgs 1)
            ) enablePkgWithArgList);

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
        enablePkgWith = package: optionName:
            lib.mkIf config.apeiron.${optionName}.enable {
                environment.systemPackages = [ package ];
            };
        enableEachPkgWith = enablePkgWithArgList:
            lib.mkMerge ( builtins.map ( enablePkgWithArgs:
                enablePkgWith (builtins.elemAt enablePkgWithArgs 0) (builtins.elemAt enablePkgWithArgs 1)
            ) enablePkgWithArgList);
        persistIf = optionName: directories: files: 
            lib.mkIf (config.apeiron.${optionName}.enable && config.apeiron.persistence.enable) {
                environment.persistence."/pers" = {
                    directories = directories;
                    files = files;
                };
            };
    };

}
