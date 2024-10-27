{ config, lib, ... }: {

    # Set a toggle to enable Thunderbird
    # By default, this is disabled
    options = {
        thunderbird-home.enable = lib.mkEnableOption "Enables Thunderbird with Home Manager";
    };
 
    config = lib.mkIf config.thunderbird-home.enable 
    {
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
