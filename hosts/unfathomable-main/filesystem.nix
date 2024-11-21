# Filesystem setup for impermanence
{ ... }: 
let
    rootPartition = "/dev/disk/by-uuid/909d9564-7ff5-44a4-b327-d7356acb10cd";
in
{
    # For some reason this was not enabled in the hardware configuration, even though I have an an hdd
    boot.supportedFilesystems = [ "ntfs" ];

    # Required for persisting in home-manager
    programs.fuse.userAllowOther = true;

    # Required for importing user password hash files
    users.mutableUsers = false;

    fileSystems = {

        # The boot partition is configured using the defaults in hardware-configuration.nix

        "/" = {
            device = "none";
            fsType = "tmpfs";
            neededForBoot = true;
            options = [ "defaults" "size=4G" "mode=755" ];
        };

        "/nix" = {
            device = rootPartition;
            fsType = "btrfs";
            neededForBoot = true;
            options = [ "subvol=@nix" ];
        };

        "/pers" = {
            device = rootPartition;
            fsType = "btrfs";
            neededForBoot = true;
            options = [ "subvol=@persist" ];
        };

        "/pers/home" = {
            device = rootPartition;
            fsType = "btrfs";
            neededForBoot = true;
            depends = [ "/pers" ];
            options = [ "subvol=@home" ];
        };

        "/media/VMs" = {
            device = rootPartition;
            fsType = "btrfs";
            options = [ "subvol=@vms" ];
        };

        "/media/Hdd" = {
            device = "/dev/disk/by-uuid/0C22944922943A22";
            fsType = "ntfs";
            options = [ "permissions" ];
        };

        "/var/lib/libvirt/images/persistent" = {
            device = "/media/VMs/persistent";
            depends = [ "/media/VMs" ];
            options = [ "bind" ];
        };
    };
}
