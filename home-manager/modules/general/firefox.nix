{ config, pkgs, lib, ... }: {

    # Set a toggle to enable Firefox
    options = {
        firefox-home.enable = lib.mkEnableOption "Enables Firefox with Home Manager";
    };
    
    config = lib.mkIf config.firefox-home.enable 
    {
        programs.firefox = {
            enable = true;

            # This "user" profile will be automatically added by home manager.
            profiles.user = {
                bookmarks = [
                    {
                        name = "toolbar";
                        toolbar = true;
                        bookmarks = [
                            {
                                name = "Onshape";
                                url = "https://cad.onshape.com/signin";
                            }
                            {
                                name = "Canvas";
                                url = "http://cascadia.instructure.com";
                            }
                        ];
                    }
                ];

                # See "about:config" for more settings.
                settings = {
                    "app.shield.optoutstudies.enabled" = false;
                    "browser.discovery.enabled" = false;
                    "browser.download.useDownloadDir" = false;
                    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                    "browser.preferences.defaultPerformanecSettings.enabled" = false;
                    "browser.privatebrowsing.autostart" = true;
                    "browser.search.suggest.enabled.private" = true;
                    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
                    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
                    "datareporting.healthreport.uploadEnabled" = false;
                    "extensions.pocket.enabled" = false;
                    "geo.enabled" = false;
                    "privacy.firstparty.isolate" = true;
                    "privacy.donottrackheader.enabled" = true;
                    "privacy.globalprivacycontrol.enabled" = true;
                    "privacy.sanitize.sanitizeOnShutdown" = true;
                };
            };

            # These are workspace policy settings that apply for all users of the browser.
            # Most of these can be set locally in the profile, but redundency ensures these won't be changed.
            policies = {
                DisablePocket = true;
                DisableTelemetry = true;
                EnableTrackingProtection = true;
            };
        };
    };
}
