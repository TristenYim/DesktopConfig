{ config, lib, ... }: {

    # Set a toggle to enable git
    options.apeiron = {
        git.enable = lib.mkEnableOption "git";
        lazygit.enable = lib.mkEnableOption "git";
    };
 
    config = lib.mkMerge
    [
        (lib.mkIf config.apeiron.git.enable {
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
            apeiron.lazygit.enable = lib.mkDefault true;
        })
        (lib.mkIf config.apeiron.lazygit.enable {
            programs.lazygit.enable = true;
        })
    ];
}
