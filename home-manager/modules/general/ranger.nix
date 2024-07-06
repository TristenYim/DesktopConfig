{ config, pkgs, lib, ... }: {

    # Set a toggle to enable ranger
    options = {
        ranger-home.enable = lib.mkEnableOption "Enables ranger with Home Manager";
    };
 
    config = lib.mkIf config.ranger-home.enable 
    {
        programs.ranger = {
            enable = true;
            extraConfig =
                "set show_hidden true";
            rifle = [
               { condition = "mime ^text, label editor"; command = "vim -- \"$@\""; }
               { condition = "!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|js|sh|php"; command = "vim -- \"$@\""; }
            ];
        };
    };
}
