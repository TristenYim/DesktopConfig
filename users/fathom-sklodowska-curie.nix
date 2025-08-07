{ ... }:

{
    imports = [
        ./fathom-default.nix
    ];

    config = {
        # Enable custom module options
        apeiron = {
            terminal.brightnessctl.enable = true;
            persistence.enable = true;
            isStandalone = false;
        };

        programs.nixvim.plugins.orgmode.settings.org_agenda_files = "/media/Sync/Notes/Todo.org";

        home = {
            sessionVariables = {
                FLAKE = "/etc/nixos";
            };
        };
    };
}
