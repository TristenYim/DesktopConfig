# This enables gpu passthrough in virtual machines

# This requires writing custom QEMU hook scripts that I can't cleanly configure with nix right now
# See https://www.reddit.com/r/VFIO/comments/1ekutot/softlock_on_dynamic_unbind_of_nvidia_gpu/
# for details on what these scripts will look like

{ config, lib, ... }: {
    options = {
        virtualisation.passthrough.enable = lib.mkEnableOption "Enables single gpu passthrough in declared vms.";
    };

    config = ( lib.mkIf (config.virtualisation.enable && config.virtualisation.passthrough.enable) {

        # See https://www.reddit.com/r/VFIO/comments/p4kmxr/tips_for_single_gpu_passthrough_on_nixos/ 
        # information about hooks, if the hook env breaks again. In practice, this doesn't appear to
        # be necessary.

        # Required kernel modules and params
        boot = {
            kernelModules = [
                "vfio_pci"

                # Technically not necessary since these are loaded automatically with vfio_pci
                "vfio_iommu_type1"
                "vfio"
            ];

            kernelParams = [
                "intel_iommu=on"
                "iommu=pt"
                # "video=1920x1080,efifb:off"
            ];
        };
    });
}

