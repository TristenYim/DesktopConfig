{ config, lib, ... }: {

    # Set a toggle to enable git
    options.apeiron.terminal = {
        git.enable = lib.mkEnableOption "git";
        lazygit.enable = lib.mkEnableOption "lazygit";
    };
 
    config = lib.mkMerge
    [
        (lib.mkIf config.apeiron.terminal.git.enable {
            programs.git = {
                enable = true;
                userEmail = "unfathomy@proton.me";
                userName = "TristenYim";
                extraConfig = {
                    safe = {
                        directory = [
                            "/etc/nixos"
                            "/media/Hdd/SchoolNotes"
                        ];
                    };
                };
            };
            apeiron.terminal.lazygit.enable = lib.mkDefault true;
        })
        (lib.mkIf config.apeiron.terminal.lazygit.enable {
            programs.lazygit.enable = true;
        })
    ];
}
