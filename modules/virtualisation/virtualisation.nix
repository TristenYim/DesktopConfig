# This enables creating virtual machines
{ config, pkgs, lib, ... }: 
let
    myLib = import ../../resources/myLib.nix { inherit config lib; };
in
{
    imports = [
        ./passthrough.nix
        ( myLib.nixos.mkPersistenceModule [ "/var/lib/libvirt/qemu" "/var/lib/libvirt/hooks/custom" ] [ ] [ "virtualisation" ] )
    ];

    options.apeiron = {
        virtualisation.enable = lib.mkEnableOption "the creation of virtual machines";
    };

    config = lib.mkIf config.apeiron.virtualisation.enable {
        # Libvirt is the virtualisation library
        virtualisation = {
            libvirtd = {
                enable = true;
                qemu = {
                    swtpm.enable = true; # TPM, required for Windows VMs
    
                    # Secure boot, required for Windows VMs
                    ovmf = {
                        enable = true;
                        packages = [ pkgs.OVMFFull.fd ];
                    };
    
                    # Enables VM filesystem mounts
                    vhostUserPackages = [ pkgs.virtiofsd ];
                };
                hooks.qemu.custom = ./qemu.sh;
            };
    
            # Allows hotplugging of USB peripherals
            spiceUSBRedirection.enable = true;
        };
    
        # Enable virt-manager, a GUI virtual machine manager
        programs.virt-manager.enable = true;
    
        # Adds support for useful features such as dynamic VM resizing and clipboard sharing 
        services.spice-vdagentd.enable = true;
    
        # Extra packages for Windows VMs
        environment.systemPackages = with pkgs; [
            virtio-win
            win-spice
            virtiofsd
        ];
    
        # Add users to the libvirtd group to allow them to create VMs
        users.users."fathom".extraGroups = [ "libvirtd" ];
        users.users."tdoggy".extraGroups = [ "libvirtd" ];
    };
}
