{ config, pkgs, lib, ... }: {

    # Set a toggle to enable foo
    # By default, this is disabled
    options = {
        foo-home.enable = lib.mkEnableOption "Enables foo with Home Manager";
    };
 
    config = lib.mkIf config.foo-home.enable 
    {
        # Write your config here
    };
}
