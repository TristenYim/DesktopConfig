{ config, pkgs, lib, ... }: {
    config = lib.mkIf config.hyprland-home.enable 
    {
        wayland.windowManager.hyprland.settings = {
            cursor = {
                no_hardware_cursors = true;
            };
            # render.explicit_sync = 0;
            env = [ 
                # Environment Variables NVIDIA Specific

                # See the wiki for more info as some work is required
                # https://wiki.hyprland.org/hyprland-wiki/pages/Nvidia/

                # Hardware acceleration on NVIDIA GPUs
                # See Archwiki Hardware Acecleration Page for details and necessary values before setting this variable.
                # https://wiki.archlinux.org/title/Hardware_video_acceleration
                "LIBVA_DRIVER_NAME,nvidia"

                # The lines below may cause issues, proceed at your own risk

                # To force GBM as a backend, set the following environment variables:
                # See Archwiki Wayland Page for more details on those variables.
                # https://wiki.archlinux.org/title/Wayland#Requirements
                "GBM_BACKEND,nvidia-drm"
                "__GLX_VENDOR_LIBRARY_NAME,nvidia"

                # Controls if G-Sync capable monitors should use Variable Refresh Rate (VRR)
                # See Nvidia Documentation for details.
                # https://download.nvidia.com/XFree86/Linux-32bit-ARM/375.26/README/openglenvvariables.html
                #env = __GL_GSYNC_ALLOWED,

                # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.   
                #env = __GL_VRR_ALLOWED,

                # use legacy DRM interface instead of atomic mode setting. Might fix flickering issues.
                #env = WLR_DRM_NO_ATOMIC,1
            ];
        };
    };
}
