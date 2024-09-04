{ config, pkgs, lib, ... }: {

    config = lib.mkIf config.firefox-home.enable 
    {
        programs.firefox.profiles.user.bookmarks = [
            {
                name = "toolbar";
                toolbar = true;
                bookmarks = [
                    {
                        name = "Onshape";
                        url = "https://cad.onshape.com/signin";
                    }
                    {
                        name = "Parts Spreadsheet";
                        url = "https://1drv.ms/x/s!AvG_9368w1UWiMMyIniavypEa9eF-Q";
                    }
                    {
                        name = "Screw Sizes";
                        url = "https://littlemachineshop.com/images/gallery/PDF/TapDrillSizes.pdf";
                    }
                    {
                        name = "Chief Delphi";
                        url = "https://www.chiefdelphi.com";
                    }
                    {
                        name = "FIRST Vendors";
                        bookmarks = [
                            {
                                name = "McMaster-Carr";
                                url = "https://www.mcmaster.com";
                            }
                            {
                                name = "Andymark";
                                url = "https://www.andymark.com";
                            }
                            {
                                name = "WestCoast Products";
                                url = "https://wcproducts.com";
                            }
                            {
                                name = "REV Robotics";
                                url = "https://www.revrobotics.com";
                            }
                            {
                                name = "goBILDA";
                                url = "https://www.gobilda.com";
                            }
                            {
                                name = "ThriftyBot";
                                url = "https://www.thethriftybot.com";
                            }
                        ];
                    }
                    {
                        name = "Linux";
                        bookmarks = [
                            {
                                name = "Hyprland";
                                url = "https://wiki.hyprland.org";
                            }
                            {
                                name = "kitty";
                                url = "https://sw.kovidgoyal.net/kitty";
                            }
                            {
                                name = "Rofi";
                                url = "https://github.com/davatorium/rofi";
                            }
                            {
                                name = "Waybar";
                                url = "https://github.com/Alexays/Waybar";
                            }
                            {
                                name = "NixOS Manual";
                                url = "https://nixos.org/manual/nixos/unstable";
                            }
                            {
                                name = "Home Manager Manual";
                                url = "https://nix-community.github.io/home-manager";
                            }
                        ];
                    }
                    {
                        name = "Canvas";
                        url = "http://cascadia.instructure.com";
                    }
                    {
                        name = "WAMAP";
                        url = "https://www.wamap.org";
                    }
                    {
                        name = "vistas";
                        url = "https://www.vhlcentral.com";
                    }
                ];
            }
        ];
    };
}
