# Filesystem setup for impermanence
{ config, lib, ... }: 
let
    rootPartition = "/dev/disk/by-uuid/909d9564-7ff5-44a4-b327-d7356acb10cd";
in
{
    fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
        neededForBoot = true;
        options = [ "defaults" "size=4G" "mode=755" ];
    };

    fileSystems."/pers" = {
        device = rootPartition;
        fsType = "btrfs";
        neededForBoot = true;
        options = [ "subvol=@persist" ];
    };

    fileSystems."/nix" = {
        device = rootPartition;
        fsType = "btrfs";
        neededForBoot = true;
        options = [ "subvol=@nix" ];
    };

    # The boot partition is configured using the defaults in hardware-configuration.nix
}
