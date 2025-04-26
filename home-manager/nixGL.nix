# Defines the nixGL option and sets the package.

# Programs should be wrapped in their own configuration
# files, not here.

{ config, lib, nixgl, ... }: {

    options.apeiron = {
        nixGL.enable = lib.mkEnableOption "nixGL wrapping of necessary packages";
    };

    config = lib.mkIf config.apeiron.nixGL.enable {
        # Set nixGL package
        nixGL.packages = nixgl.packages;
    };
}
