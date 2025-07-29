{ config, pkgs, lib, myLib, firefox-addons, ... }: {
    imports = [
        ./bookmarks-firefox.nix
        ./engines-firefox.nix

        ( myLib.home.mkPersistenceModule [ ".mozilla/firefox/default" ] [ ] [ "desktop" "browsers" "firefox" ] ) # Saves default profile data
    ];

    # Set a toggle to enable Firefox
    options.apeiron.desktop.browsers = {
        firefox.enable = lib.mkEnableOption "Firefox";
    };
    
    config = lib.mkIf config.apeiron.desktop.browsers.firefox.enable {
        programs.firefox = {
            enable = true;
            betterfox.enable = true;
            package = pkgs.firefox-beta;

            profiles.default = {
                betterfox = {
                    enable = true;
                    enableAllSections = true;
                };

                extensions = {
                    force = true;
                    packages = with firefox-addons.packages."x86_64-linux"; [
                        bitwarden
                        canvasblocker
                        dearrow
                        ublacklist
                        ublock-origin
                        user-agent-string-switcher
                        sponsorblock
                        web-scrobbler
                    ];
                };

                # See "about:config" for more settings.
                settings = {
                    # Hardware Acceleration
                    # See https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
                    # and https://github.com/elFarto/nvidia-vaapi-driver#firefox for more details
                    "gfx.webrender.all" = true;
                    "gfx.x11-egl.force-enabled" = true;
                    "media.ffmpeg.vaapi.enabled" = true;

                    "browser.download.useDownloadDir" = false;
                    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                    "browser.preferences.defaultPerformanceSettings.enabled" = false;
                    "browser.search.suggest.enabled.private" = true;
                    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
                    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
                    "extensions.autoDisableScopes" = 0;
                    "extensions.formautofill.addresses.enabled" = false;
                    "extensions.formautofill.creditCards.enabled" = false;
                    "geo.enabled" = false;
                    "signon.rememberSignons" = false;
                    "privacy.donottrackheader.enabled" = true;
                    "privacy.fingerprintingProtection" = true;
                    "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
                    "privacy.sanitize.sanitizeOnShutdown" = true;
                    "pref.privacy.disable_button.view_passwords" = false;
                    "trailhead.firstrun.didSeeAboutWelcome" = true;
                };
            };

            # These are workspace policy settings that apply for all users of the browser.
            # Most of these can be set locally in the profile, but policies ensure these cannot ever be disabled.
            # See https://mozilla.github.io/policy-templates/ for more information.
            policies = {
                AutofillAddressEnabled = false;
                AutofillCreditCardEnabled = false;
                Cookies.Allow = [
                    "https://bitwarden.com"
                    "https://search.brave.com"
                    "https://proton.me"
                ];
                DisablePocket = true;
                DisableTelemetry = true;
                EnableTrackingProtection = true;
            };
        };
    };
}
