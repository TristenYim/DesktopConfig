{ config, lib, ... }: {

    # Set a toggle to enable ranger
    options.apeiron.terminal = {
        ranger.enable = lib.mkEnableOption "ranger";
    };
 
    config = lib.mkIf config.apeiron.terminal.ranger.enable 
    {
        programs.ranger = {
            enable = true;
            extraConfig =
                "set show_hidden true";
            rifle = [
               { condition = "mime ^text, label editor"; command = "vim -- \"$@\""; }
               { condition = "!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|js|sh|php"; command = "vim -- \"$@\""; }
               { condition = "mime ^video, X, flag f"; command = "mpv -- \"$@\""; }
               { condition = "mime ^image, X, !ext gif, flag f"; command = "feh -- \"$@\""; }
               { condition = "ext pdf, X, flag f"; command = "firefox-beta -- \"$@\""; }
               { condition = "ext docx?, X, flag f"; command = "wps -- \"$@\""; }
               { condition = "label open, has xdg-open"; command = "xdg-open = \"$@\""; }
            ];
        };
    };
}
