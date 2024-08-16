{ config, pkgs, lib, ... }: {
    options = {
        users-fathom.enable = lib.mkEnableOption "Enables fathom, the productivity user. fathom uses Hyprland.";
        users-tdoggy.enable = lib.mkEnableOption "Enables tdoggy, the gaming user. tdoggy uses Xfce.";
    };

    config = lib.mkMerge
    [
        # For some reason this must be made default here
        {
           users-fathom.enable = lib.mkDefault true;
        }

        # fathom, the productivity account
        ( lib.mkIf config.users-fathom.enable {
            users.users.fathom = {
                isNormalUser = true;
                description = "unfathomable-surface";
                extraGroups = [ "networkmanager" "wheel" "nix-config-perms" ];
                packages = with pkgs; [];
                initialPassword = "123456";
            };
        })

        # tdoggy, the gaming account 
        ( lib.mkIf config.users-tdoggy.enable {
            users.users.tdoggy = {
                isNormalUser = true;
                description = "tdoggied-surface";
                extraGroups = [ "networkmanager" "wheel" "nix-config-perms" ];
                packages = with pkgs; [];
            };
        })
    ];
}
