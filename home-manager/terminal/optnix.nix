{
    imports = [
        ({ config, pkgs, lib, optnix, ... }: 
        let
            cfg = config.programs.optnix;
            tomlFormat = pkgs.formats.toml { };
        in
        {
            options.programs.optnix = {
                enable = lib.mkEnableOption "optnix, nix option search tool by water-sucks";

                package = lib.mkPackageOption optnix.packages.${pkgs.system} "optnix" { nullable = true; };

                settings = lib.mkOption {
                    type = tomlFormat.type;
                    default = { };
                    example = lib.literalExpression ''
                        # TODO Add example
                    '';
                    description = ''
                        # TODO Add description
                    '';
                };
            };

            config = lib.mkIf cfg.enable {
                home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

                xdg.configFile."optnix/config.toml" = lib.mkIf (cfg.settings != { }) {
                    source = tomlFormat.generate "config.toml" cfg.settings;
                };
            };
        })
    ];
}
