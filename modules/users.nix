{ config, pkgs, lib, ... }: {
    options = {
        users-fathom.enable = lib.mkEnableOption "Enables fathom, the productivity user. fathom uses Hyprland.";
        users-tdoggy.enable = lib.mkEnableOption "Enables tdoggy, the gaming user. tdoggy uses Xfce.";
    };

    config = lib.mkMerge
    [
        {
           users-fathom.enable = lib.mkDefault true;
           users.groups.nixos-config-editor = {}; # Group for giving (local) users write access to /etc/nixos
        }

        # fathom, the productivity account
        ( lib.mkIf config.users-fathom.enable {
            users.users.fathom = {
                isNormalUser = lib.mkDefault true;
                description = lib.mkDefault "For productivity. Use with Hyprland.";
                extraGroups = lib.mkDefault [ "networkmanager" "wheel" "nixos-config-editor" ];
                initialPassword = lib.mkDefault "123456";
            };
        })

        # tdoggy, the gaming account 
        ( lib.mkIf config.users-tdoggy.enable {
            users.users.tdoggy = {
                isNormalUser = lib.mkDefault true;
                description = lib.mkDefault "For gaming. Use with XFCE.";
                extraGroups = lib.mkDefault [ "networkmanager" "wheel" "nixos-config-editor" ];
            };
        })
    ];
}
