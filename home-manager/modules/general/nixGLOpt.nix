{ lib, ...}:

# See https://github.com/nix-community/nixGL/issues/114#issuecomment-1585323281 for more

{
    options.nixGLPrefix = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = ''
            Will be prepended to commands which require working OpenGL.

            This needs to be set to the right nixGL package on non-NixOS systems.
        '';
    };
}
