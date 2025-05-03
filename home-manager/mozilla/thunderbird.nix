{ config, lib, ... }: 
let
    myLib = import ../../resources/myLib.nix { inherit config lib; };
in
{
    imports = [
        ( myLib.home.mkPersistenceModule [ ".thunderbird/user" ] [ ] [ "thunderbird" ] )
    ];

    # Set a toggle to enable Thunderbird
    # By default, this is disabled
    options.apeiron = {
        thunderbird.enable = lib.mkEnableOption "Thunderbird";
    };
 
    config = lib.mkIf config.apeiron.thunderbird.enable {
        programs.thunderbird = {
            enable = true;
            profiles.user = {
                isDefault = true;
                settings = {
                    "datareporting.healthreport.uploadEnabled" = false;
                    "mail.compose.autosaveinterval" = 1;
                    "mail.shell.checkDefaultClient" = false;
                    "mail.tabs.drawInTitlebar" = false;
                    "mailnews.start_page.enabled" = false;
                    # "network.cookie.cookieBehavior" = 2; # In practice, this option ends up being extremely annoying since it prevents signing into certain emails.
                    "places.history.enabled" = false;
                    "privacy.clearOnShutdown.cache" = true;
                    "privacy.donottrackheader.enabled" = true;
                };
            };
        };
    };
}
