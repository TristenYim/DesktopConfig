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

        # TODO Implement conditional standalone and embedded logic
        # (if the system is not nixos, don't create a scope for it).
        ({ config, lib, ... }: 
        let
            cfg = config.apeiron.terminal.optnix;
        in
        {
            options.apeiron.terminal.optnix = {
                enable = lib.mkEnableOption "optnix";
                hostname = lib.mkOption {
                    type = lib.types.str;
                    default = "";
                };
            };
        
            config = lib.mkIf cfg.enable {
                programs.optnix = {
                    enable = true;
        
                    # See https://github.com/water-sucks/optnix for all options
                    settings = {
                        min_score = 1;
                        debounce_time = 25;
                        default_scope = "";
                        formatter_cmd = "nixfmt";
                        
                        scopes = {
                            nixos = {
                                description = "NixOS configuration for ${cfg.hostname}";
                                options-list-cmd = ''
                                    nix eval "$FLAKE/build#nixosConfigurations.${cfg.hostname}" --json --apply 'input: let
                                        inherit (input) options pkgs;

                                        optionsList = builtins.filter
                                            (v: v.visible && !v.internal)
                                            (pkgs.lib.optionAttrSetToDocList options);
                                    in
                                        optionsList'
                                '';

                                # Does not produce useful output despite being nearly
                                # identical to the example. Will fix later
                                evaluator = "nix eval $FLAKE/build#nixosConfigurations.${cfg.hostname}.config.{{ .Option }}";
                            };

                            # TODO Fix home options-list-cmd
                            home = {
                                description = "Home configuration for ${config.home.username}";
                                options-list-cmd = ''
                                    nix eval "$FLAKE/build#homeConfigurations.${config.home.username}" --json --apply 'input: let
                                        inherit (input) options pkgs;

                                        optionsList = builtins.filter
                                            (v: v.visible && !v.internal)
                                            (pkgs.lib.optionAttrSetToDocList options);
                                    in
                                        optionsList'
                                '';
                            };
                        };
                    };
                };
            };
        })
    ];
}
