{ config, pkgs, lib, inputs, ... }: {
    # Note that inputs is from the terrible "extraSpecialArgs" syntax

    imports = [
        ./bookmarks-firefox.nix
        ./engines-firefox.nix
    ];

    # Set a toggle to enable Firefox
    options = {
        firefox-home.enable = lib.mkEnableOption "Enables Firefox with Home Manager";
    };
    
    config = lib.mkIf config.firefox-home.enable 
    {
        programs.firefox = {
            enable = true;
            package = pkgs.firefox-beta;

            # This "user" profile will be automatically added by home manager.
            profiles.user = {
                extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
                    bitwarden
                    dearrow
                    ublacklist
                    ublock-origin
                    sponsorblock
                    web-scrobbler
                ];

                # See "about:config" for more settings.
                settings = {
                    # Hardware Acceleration
                    # See https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
                    # and https://github.com/elFarto/nvidia-vaapi-driver#firefox for more details
                    "gfx.webrender.all" = true;
                    "gfx.x11-egl.force-enabled" = true;
                    "media.ffmpeg.vaapi.enabled" = true;

                    "app.shield.optoutstudies.enabled" = false;
                    "browser.aboutConfig.showWarning" = false;
                    "browser.discovery.enabled" = false;
                    "browser.download.useDownloadDir" = false;
                    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                    "browser.preferences.defaultPerformanecSettings.enabled" = false;
                    "browser.search.suggest.enabled.private" = true;
                    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
                    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
                    "datareporting.healthreport.uploadEnabled" = false;
                    "extensions.pocket.enabled" = false;
                    "extensions.autoDisableScopes" = 0;
                    "geo.enabled" = false;
                    "signon.rememberSignons" = false;
                    "privacy.firstparty.isolate" = true;
                    "privacy.donottrackheader.enabled" = true;
                    "privacy.globalprivacycontrol.enabled" = true;
                    "privacy.sanitize.sanitizeOnShutdown" = true;
                    "pref.privacy.disable_button.view_passwords" = false;
                    "trailhead.firstrun.didSeeAboutWelcome" = true;
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
