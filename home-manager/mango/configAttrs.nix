# Configuration-agnostic MangoWC module.

{ config, lib, ... }: 
let
    cfg = config.wayland.windowManager.mango;

    toMangoConf = 
    let
        mkItem = name: value:
            if ! builtins.isFloat value
            then "${name}=" + builtins.toString value
            else "${name}=${lib.strings.floatToString value}";
        mkSection = name: value:
            if ! builtins.isList value
            then mkItem name value
            else lib.concatMapStringsSep "\n" (e: mkItem name e) value;
    in attrs: lib.concatMapAttrsStringSep "\n" (mkSection) attrs;
in
{
    options.wayland.windowManager.mango = {
        configAttrs = lib.mkOption {
            type = 
                with lib.types;
                let
                    valueType = nullOr (oneOf [
                        int
                        float
                        str
                        path
                        (listOf valueType)
                    ]) // { description = "Mango config as an attribute set"; };
                in attrsOf valueType;
            default = { };
            description = ''
                MangoWC configuration written in Nix. All repeated setting
                names must be grouped in a list.

                See <https://github.com/DreamMaoMao/mangowc/wiki> for more
                information.
            '';
        };
        configExtra = lib.mkOption {
            type = lib.types.lines;
            default = "";
            description = ''
                Extra configuration lines to add.
            '';
        };
    };

    config.wayland.windowManager.mango = lib.mkIf cfg.enable {
        settings = lib.mkIf (cfg.configAttrs != { } || cfg.configExtra != "") 
            (toMangoConf cfg.configAttrs + lib.optionalString (cfg.configExtra != "") "\n" + cfg.configExtra);
    };
}
