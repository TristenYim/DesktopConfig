{ config, lib, ... }: {

    # Set a toggle to enable git
    options = {
        git-home.enable = lib.mkEnableOption "Enables git with Home Manager";
        lazygit-home.enable = lib.mkEnableOption "Enables git with Home Manager";
    };
 
    config = lib.mkMerge
    [
        (lib.mkIf config.git-home.enable {
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
            lazygit-home.enable = lib.mkDefault true;
        })
        (lib.mkIf config.lazygit-home.enable {
            programs.lazygit.enable = true;
        })
    ];
}
