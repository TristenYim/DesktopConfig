# Filesystem setup for impermanence
{ ... }: 
let
    mkZfsMount = dataset: {
        device = "zroot/${dataset}";
        fsType = "zfs";
        neededForBoot = true;
    };
in
{
    # Required for persisting in home-manager
    programs.fuse.userAllowOther = true;

    # Required for importing user password hash files
    users.mutableUsers = false;

    networking.hostId = "e2563248"; # A completely random, arbitrary ID for making ZFS work

    fileSystems = {
        "/boot" = {
            device = "/dev/disk/by-uuid/30DA-A6CD";
            fsType = "vfat";
            options = [ "fmask=0022" "dmask=0022" ];
        };

        "/" = {
            device = "none";
            fsType = "tmpfs";
            neededForBoot = true;
            options = [ "defaults" "size=500M" "mode=755" ];
        };

        "/nix" = mkZfsMount "nix";

        "/pers" = mkZfsMount "encrypted/persistent";

        "/pers/home" = mkZfsMount "encrypted/home";

        "/media/Sync" = mkZfsMount "encrypted/sync";
    };
}
