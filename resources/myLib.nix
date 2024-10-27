# This is a custom function library, similar to nixpkgs lib.
# The reason why I'm doing it this way instead of extending lib is lib cannot 
# reference config (it will throw an infinite recursion error).

# Later, I may merge things such as nixGLWrap and catppuccin colors into this.

{ config, pkgs, lib }:

{
    home = rec {
        # Adds a set of packages when an enable option is true.
        # Note that since every option in my home-manager configuration adds
        # "-home" to the end of its option names, the "-home" is excluded
        # from the argument.
        enablePkgsWith = packageList: optionNameWithoutHome:
            lib.mkIf config.${optionNameWithoutHome + "-home"}.enable { 
                home.packages = packageList; 
            };

        # Enables a single package when an option name is true.
        enablePkgWith = packageName: optionNameWithoutHome:
            enablePkgsWith [ pkgs.${packageName} ] optionNameWithoutHome;

        # Enables a single package with an identically named option.
        enablePkgSameOptName = name:
            enablePkgWith name name;
    };
    nixos = rec {
        enablePkgWith = packageName: optionName:
            lib.mkIf config.${optionName}.enable {
                environment.systemPackages = [
                    pkgs.${packageName}
                ];
            };
        enablePkgSameOptName = name:
            enablePkgWith name name;
    };
}
